//
//  AppleMusicViewModel.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 08/04/2025.
//

import Foundation
import SwiftUI
import AVKit

class AppleMusicViewModel: ObservableObject {
    //Model Instance
    @Published var musicData: [MusicData] = sampleMusicData
    //Bool
    @Published var isLiked: Bool = false {
        didSet {
            if isLiked {
                if !musicLiked.contains(currentMusic()) {
                    musicLiked.append(currentMusic())
                }
            }
        }
    }
    
    @Published var optionButton: Bool = false
    //Double/Int
    @Published var volume: Double = 0.5
    @Published var totalVolume: Double = 100.5
    @Published var selectedMusic: Int = 0
    @Published var progress: Double = 1.0
    //Timer
    @Published var timer: Timer? = nil
    //AVKit
    @Published var player: AVAudioPlayer?
    @Published var isPlaying: Bool = false
    @Published var totalTime: TimeInterval = 0.0
    @Published var currentTimes: TimeInterval = 0.0
    
    @Published var musicLiked: [MusicData] = []
    
    func linearGradient() -> LinearGradient {
        return LinearGradient(gradient: Gradient(colors: [currentMusic().backgroundCover, .black]), startPoint: .top, endPoint: .bottom)
    }
    
    func currentMusic() -> MusicData {
         musicData[selectedMusic]
    }
    
    func removeItems(at offsets: IndexSet) {
        musicLiked.remove(atOffsets: offsets)
        isLiked = false
    }
    
    func toggleLike() {
            if !musicLiked.contains(currentMusic()) {
                musicLiked.append(currentMusic())
                isLiked = true
            }
        }
    
    func updateIsLikedState() {
        isLiked = musicLiked.contains(currentMusic())
    }
    
    //Toggle the play/pause state with spring animation
     func togglePlay() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
            isPlaying.toggle()
        }
    }
    // Format a time value (in seconds) to a string in "m:ss" format
     func timeString(time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
    //Audio Player
     func setupAudio() {
        stopAudio()
        guard let url = Bundle.main.url(forResource: currentMusic().music, withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
            print("Music selected: \(currentMusic().title) - \(currentMusic().artist)")
        } catch {
            print("Error loading audio: \(error)")
        }
    }
    
    func playAudio() {
        guard let player = player else { return }
        player.play()
        isPlaying = true
    }
    
    func stopAudio() {
        guard let player = player else { return }
        player.stop()
        isPlaying = false
    }
    
    func updateProgress() {
        guard let player = player else { return }
        currentTimes = player.currentTime
        progress = Double(currentTimes) / totalTime
    }
    
    func audioTime(to time: TimeInterval) {
     player?.currentTime = time
    }
    
    func backForward() {
       if selectedMusic > 0 {
            selectedMusic -= 1
       }
    }
    
    func moveForward() {
        if selectedMusic < musicData.count - 1 {
             selectedMusic += 1
        }
    }
    
    func hapticReturn(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func successFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
    }
}
