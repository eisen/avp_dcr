//
//  AVP_DCRApp.swift
//  AVP_DCR
//
//  Created by Eisen Montalvo on 2/10/24.
//

import SwiftUI

@main
struct AVP_DCRApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)
            .defaultSize(width: 10, height: 10, depth: 10, in: .meters)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}

