//
//  _dMCparticleApp.swift
//  Shared
//
//  Created by anthony lim on 1/21/22.
//

import SwiftUI

@main
struct _dMCparticleApp: App {
    @StateObject var oneD = OneDScattering()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(oneD)
        }
    }
}
