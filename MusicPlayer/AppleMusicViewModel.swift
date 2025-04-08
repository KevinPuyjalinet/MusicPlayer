//
//  AppleMusicViewModel.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 08/04/2025.
//

import Foundation
import SwiftUI

class AppleMusicViewModel: ObservableObject {
    //Model Instance
    @Published var musicData: [MusicData] = sampleMusicData
    //Bool
    @Published var isLiked: Bool = false
    @Published var isPlaying: Bool = false
    @Published var optionButton: Bool = false
    //Double/Int
    @Published var currentTime: Double = 120
    @Published var volume: Double = 0.5
    @Published var totalVolume: Double = 1
    @Published var selectedMusic: Int = 0
    @Published var progress: Double = 1.0
    //Timer
    @Published var timer: Timer? = nil
    
     var currentMusic: MusicData {
         musicData[selectedMusic]
    }
    
    //Toggle the play/pause state with spring animation
     func togglePlay() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
            isPlaying.toggle()
        }
    }
    // Format a time value (in seconds) to a string in "m:ss" format
     func timeString(time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
