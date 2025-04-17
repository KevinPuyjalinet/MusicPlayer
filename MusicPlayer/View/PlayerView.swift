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
            .tint(viewModel.currentMusic().backgroundCover)
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
                //MARK: - Back Forward Button
                Button {
                    //Action for previous track
                    viewModel.backForward()
                    viewModel.hapticReturn(style: .light)
                } label: {
                    Image(systemName: "backward.fill")
                        .font(.title2)
                }.disabled(viewModel.selectedMusic == 0)
                 .foregroundStyle(viewModel.selectedMusic == 0 ? .white.opacity(0.3) : .white)
                
                //MARK: - Play/Pause Button
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
                .onChange(of: viewModel.currentMusic()) {
                    viewModel.setupAudio()
                }
                .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                    viewModel.updateProgress()
                }
                
                //MARK: - Move Forward Button
                Button {
                    viewModel.moveForward()
                    viewModel.hapticReturn(style: .light)
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                }.disabled(viewModel.selectedMusic == 3)
                 .foregroundStyle(viewModel.selectedMusic == 3 ? .white.opacity(0.3) : .white)
            }
            .foregroundStyle(Color.white)
            
            //MARK: - Slider Volume
            HStack {
                Button {
                    viewModel.volume = max(viewModel.volume - 10, 0)
                    viewModel.hapticReturn(style: .light)
                } label: {
                    Image(systemName: "speaker.fill")
                        .font(.title2)
                }.disabled(viewModel.volume <= 0.5)
                    .foregroundStyle(viewModel.volume <= 0.5 ? Color.white.opacity(0.3) : Color.white)
                
                    Slider(value: $viewModel.volume, in: 0...Double(viewModel.totalVolume))
                        .tint(viewModel.currentMusic().backgroundCover)
                
                Button {
                    viewModel.volume = min(viewModel.volume + 10, 100)
                    viewModel.hapticReturn(style: .light)
                } label: {
                    Image(systemName: "speaker.wave.3.fill")
                        .font(.title2)
                }.disabled(viewModel.volume >= 100)
                 .foregroundStyle(viewModel.volume >= 100 ? Color.white.opacity(0.3) : Color.white)
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
