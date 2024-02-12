//
//  ContentView.swift
//  AVP_DCR
//
//  Created by Eisen Montalvo on 2/10/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

import GRPC
import NIOCore
import NIOPosix

struct ContentView: View {
    var port: Int = 50051

    @State private var enlarge = false
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @State private var yaw = Angle2D(degrees: 0)
    @State private var pitch = Angle2D(degrees: 0.0)
    @State private var donut: Entity?

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        VStack {
            RealityView { content in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Donut", in: realityKitContentBundle) {
                    content.add(scene)
                    donut = content.entities.first?.findEntity(named: "donut2")
                }
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 1.4 : 1.0
                    scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                    
//                    scene.transform.rotation = simd_quatf(
//                        Rotation3D(eulerAngles:
//                                    EulerAngles(x: pitch, y: yaw, z: Angle2D(degrees: 0.0), order: .xyz)
//                                  )
//                    )
                }
            }
            .gesture(TapGesture().targetedToAnyEntity().onEnded { _ in
                enlarge.toggle()
            })
            .gesture( DragGesture().targetedToEntity(donut ?? Entity()).onChanged { dragEvent in
                guard let donut, let parent = donut.parent
                else
                {
                    return
                }
                donut.position = dragEvent.convert(dragEvent.location3D, from: .local, to: parent)
            })

            VStack (spacing: 12) {
                Toggle("Enlarge RealityView Content", isOn: $enlarge)
                    .font(.title)

                Toggle("Show ImmersiveSpace", isOn: $showImmersiveSpace)
                    .font(.title)
            }
            .frame(width: 360)
            .padding(36)
            .glassBackgroundEffect()

        }
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                        try await self.run()
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
    }
    
    func run() async throws {
        // Setup an `EventLoopGroup` for the connection to run on.
        //
        // See: https://github.com/apple/swift-nio#eventloops-and-eventloopgroups
        let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

        // Make sure the group is shutdown when we're done with it.
        defer {
          try! group.syncShutdownGracefully()
        }

        // Configure the channel, we're not using TLS so the connection is `insecure`.
        let channel = try GRPCChannelPool.with(
          target: .host("20.102.106.161", port: self.port),
          transportSecurity: .plaintext,
          eventLoopGroup: group
        )

        // Close the connection when we're done with it.
        defer {
          try! channel.close().wait()
        }

        // Provide the connection to the generated client.
        let greeter = Helloworld_HelloWorldAsyncClient(channel: channel)

        // Form the request with the name, if one was provided.
        let request = Helloworld_HelloRequest()

        do {
              let greeting = try await greeter.sayHello(request)
              print("Greeter received: \(greeting.message)")
            } catch {
              print("Greeter failed: \(error)")
            }
      }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
