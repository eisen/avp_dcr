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

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
