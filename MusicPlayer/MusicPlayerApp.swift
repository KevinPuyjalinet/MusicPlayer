//
//  MusicPlayerApp.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 04/04/2025.
//

import SwiftUI

@main
struct MusicPlayerApp: App {
    @StateObject var viewModel: AppleMusicViewModel = .init()
//    @StateObject var viewModel = AppleMusicViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
