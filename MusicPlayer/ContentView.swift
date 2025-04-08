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

struct customProgressBarView: View {
    // Binding value for progress and defined range for the progress bar
    @Binding var value: Double
    let range: ClosedRange<Double>
    var body: some View {
        ZStack(alignment: .leading) {
            GeometryReader { geometry in
                //Background track of the progress bar
                Rectangle()
                    .foregroundStyle(.gray.opacity(0.3))
                
                //Foreground progress indicator based on current value
                Rectangle()
                    .foregroundStyle(.white)
                    .frame(width: geometry.size.width * CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound)))
            }
        }
    }
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
