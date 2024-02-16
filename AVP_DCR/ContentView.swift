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
import SwiftProtobuf

struct ContentView: View {
    var port: Int = 50051

    @State private var enlarge = false
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @State private var yaw = Angle2D(degrees: 0)
    @State private var pitch = Angle2D(degrees: 0.0)
    @State private var donut: Entity?
    @State private var group: EventLoopGroup?
    @State private var channel: GRPCChannel?
    @State private var client: Donut_DonutWorldAsyncClient?
    @State private var streamCall: GRPCAsyncClientStreamingCall<Donut_Xfrm, Google_Protobuf_Empty>? = nil

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        VStack {
            RealityView { content in
                // Add the initial RealityKit content
                if let scene = try? await Entity(named: "Scene", in: realityKitContentBundle) {
                    content.add(scene)
                    donut = content.entities.first?.findEntity(named: "donut4")
                }
            } update: { content in
                // Update the RealityKit content when SwiftUI state changes
                if let scene = content.entities.first {
                    let uniformScale: Float = enlarge ? 1.4 : 1.0
                    scene.transform.scale = [uniformScale, uniformScale, uniformScale]
                }
            }
            .gesture( DragGesture().targetedToEntity(donut ?? Entity())
                .onChanged { dragEvent in
                guard let donut, let parent = donut.parent
                else
                {
                    return
                }
                donut.position = dragEvent.convert(dragEvent.location3D, from: .local, to: parent)
                    
                var rqstStream = Donut_Xfrm()
                rqstStream.locked = true
                rqstStream.position.x = donut.position.x
                rqstStream.position.y = donut.position.y
                rqstStream.position.z = donut.position.z
                
                Task {
                    try! await SendXfrmUpdate(xfrmStream: rqstStream)
                }
            }
                .onEnded({ _ in
                    var rqstStream = Donut_Xfrm()
                    rqstStream.locked = false
                    rqstStream.position.x = 0
                    rqstStream.position.y = 0
                    rqstStream.position.z = 0
                    
                    Task {
                        try! await SendXfrmUpdate(xfrmStream: rqstStream)
                        streamCall!.requestStream.finish()
                        streamCall = nil
                    }
                })
            )
            .gesture( RotateGesture3D().targetedToEntity(donut ?? Entity()).onChanged { rotateEvent in
                guard let donut
                else
                {
                    return
                }
                let rotQ = simd_quatf(angle: Float(rotateEvent.rotation.quaternion.angle), axis: SIMD3<Float>(rotateEvent.rotation.quaternion.axis))
                donut.transform.rotation *= rotQ
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
        .onAppear() {
            self.group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

            // Configure the channel, we're not using TLS so the connection is `insecure`.
            self.channel = try! GRPCChannelPool.with(
              target: .host("20.102.106.161", port: self.port),
              transportSecurity: .plaintext,
              eventLoopGroup: group!
            )
            
            self.client = Donut_DonutWorldAsyncClient(channel: self.channel!)
        }
        .onDisappear() {
            try! group!.syncShutdownGracefully()
            try! channel!.close().wait()
        }
    }
    
    func SendXfrmUpdate(xfrmStream: Donut_Xfrm) async throws
    {
        if(self.streamCall == nil) {
            self.streamCall = client!.makeSetPositionCall()
        }
        try! await streamCall!.requestStream.send(xfrmStream)
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
}
