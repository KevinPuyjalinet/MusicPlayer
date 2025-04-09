//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 04/04/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AppleMusicPlayer()
    }
}

#Preview {
    ContentView()
}

//UIViewRepresentable wrapper for UIVisualEffectView to enable blur effect in SwiftUI
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: effect)
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}
