//
//  PlayerView.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 10/04/2025.
//

import SwiftUI

struct PlayerView: View {
    @EnvironmentObject var viewModel: AppleMusicViewModel
    var body: some View {
        VStack {
            Slider(value: Binding(get: {
                viewModel.currentTimes
            }, set: { newValue in
                viewModel.audioTime(to: newValue)
            }), in: 0...viewModel.totalTime)
            .tint(viewModel.currentMusic.backgroundCover)
            .padding(.horizontal)
            
            HStack {
                Text(viewModel.timeString(time: viewModel.currentTimes))
                Spacer()
                Text(viewModel.timeString(time: viewModel.totalTime))
                
            }
            .font(.caption)
            .foregroundStyle(.gray)
            .padding(.horizontal)
        }
        //Playback controls and additional options
        VStack {
            HStack(spacing: 40) {
                Button {
                    //Action for previous track
                    viewModel.backForward()
                } label: {
                    Image(systemName: "backward.fill")
                        .font(.title2)
                }.disabled(viewModel.selectedMusic == 0)
                 .foregroundStyle(viewModel.selectedMusic == 0 ? .white.opacity(0.3) : .white)
                
                Button {
                    viewModel.isPlaying ? viewModel.stopAudio(): viewModel.playAudio()
                    print(viewModel.isPlaying)
                } label: {
                    Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 60))
                }
                .onAppear(perform: {
                    viewModel.setupAudio()
                })
                .onChange(of: viewModel.currentMusic) {
                    viewModel.setupAudio()
                }
                .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                    viewModel.updateProgress()
                }
                Button {
                    // Action for next track
                    viewModel.moveForward()
                    
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                }.disabled(viewModel.selectedMusic == 3)
                 .foregroundStyle(viewModel.selectedMusic == 3 ? .white.opacity(0.3) : .white)
            }
            .foregroundStyle(Color.white)
            
            //Volume control slider with speaker icons
            HStack {
                Button {
                    viewModel.volume -= 10
                } label: {
                    Image(systemName: "speaker.fill")
                        .font(.title2)
                }.disabled(viewModel.volume == 0.5)
                    .foregroundStyle(viewModel.volume == 0.5 ? Color.white.opacity(0.3) : Color.white)
                
                VStack {
                    Slider(value: $viewModel.volume, in: 0...Double(viewModel.totalVolume))
                        .tint(viewModel.currentMusic.backgroundCover)
                }
                
                Button {
                    viewModel.volume += 10
                } label: {
                    Image(systemName: "speaker.wave.3.fill")
                        .font(.title2)
                }.disabled(viewModel.volume == 100.5)
                    .foregroundStyle(viewModel.volume == 100.5 ? Color.white.opacity(0.3) : Color.white)
            }
            .padding(.horizontal)
            .foregroundStyle(.white)
            .padding(.top)
            
            Text("\(Int(viewModel.volume))%")
        }
    }
}

#Preview {
    PlayerView()
        .environmentObject(AppleMusicViewModel())
}
