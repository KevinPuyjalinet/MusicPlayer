//
//  AppleMusicPlayer.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 08/04/2025.
//

import SwiftUI

struct AppleMusicPlayer: View {
    //MARK: - State Variable
    @StateObject var viewModel = AppleMusicViewModel()
    @State private var likeSheet: Bool = false
    @State private var showingLyrics: Bool = false
    @State private var airPodsSheet: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var is3DYRotating: Double = 360.0
    private let totalTime: Double = 240
    private let albumArtSize: CGFloat = UIScreen.main.bounds.width - 40
    
    var body: some View {
        ZStack {
            //Background Gradient
            LinearGradient(gradient: Gradient(colors: [viewModel.currentMusic.backgroundCover, .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                    .animation(.easeInOut, value: viewModel.selectedMusic)
            
            VStack {
                HStack {
                    Button {
                        // Action for dismissing or minimizing the player
                    } label: {
                        Image(systemName: "chevron.down")
                            .font(.system(size: 20, weight: .bold))
                    }
                    Spacer()
                    
                    Text("Now Playing")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                       //Action for more options
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.degrees(90))
                    }
                }
                .foregroundStyle(.white)
                .padding()
                
                //Album Artwork Image
                
                TabView(selection: $viewModel.selectedMusic) {
                    ForEach(viewModel.musicData.indices, id: \.self) { index in
                        let music = viewModel.musicData[index]
                        Image(music.cover)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.top, 40)
                            .padding(.bottom, 90)
                            .shadow(color: .black, radius: 5, x: 0, y: 5)
                            .tag(index)
                    }
                }.tabViewStyle(.page(indexDisplayMode: .always))
                
                //Song information and like/more options
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.currentMusic.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Text(viewModel.currentMusic.artist)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    .animation(.easeInOut, value: viewModel.selectedMusic)
                    
                    Spacer()
                    Button {
                        // Like button Toggling Between liked.unliked state
                        viewModel.isLiked.toggle()
                        likeSheet.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    likeSheet = false
                                }
                        
                    } label: {
                        Image(systemName: viewModel.isLiked ? "star.circle.fill" : "star.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(viewModel.isLiked ? .yellow : .white)
                            .imageScale(.large)
                            .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp.byLayer), options: .nonRepeating))
                        
                    }.sheet(isPresented: $likeSheet) {
                        VStack(spacing: 5) {
                            Text(viewModel.isLiked ? "Musique ajouté en favoris" : "Musique supprimer en favoris")
                                .presentationDetents([.height(40)])
                                .presentationBackground(.ultraThinMaterial)
//                            ProgressView(value: viewModel.progress, total: 1.0)
//                                                .progressViewStyle(LinearProgressViewStyle())
//                                                .padding()
                        }
                    }
                    
                    //More option button with background circle
                    Menu {
                        //Action for additing options
                        Button("Option 1", action: { print("Option 1") })
                        Button("Option 2", action: { print("Option 2") })
                        
                    } label: {
                        Image(systemName: viewModel.optionButton ? "ellipsis.circle" : "ellipsis.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.white)
                                .imageScale(.large)
                    }
                    .padding(10)
                }
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom, 50)
                
                //Playback progress bar with current time and total time labels
                VStack {
                    customProgressBarView(value: $viewModel.currentTime, range: 0...totalTime)
                        .frame(height: 3)
                        .padding(.horizontal)
                    
                    HStack {
                        Text(viewModel.timeString(time: viewModel.currentTime))
                        Spacer()
                        Text(viewModel.timeString(time: totalTime))
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
                        } label: {
                            Image(systemName: "backward.fill")
                                .font(.title2)
                        }
                        Button {
                            viewModel.togglePlay()
                        } label: {
                            Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .font(.system(size: 60))
                        }
                        Button {
                            // Action for next track
                        } label: {
                            Image(systemName: "forward.fill")
                                .font(.title2)
                        }
                    }
                    .foregroundStyle(Color.white)
                    
                    //Volume control slider with speaker icons
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "speaker.fill")
                                .font(.title2)
                        }
                        
                        customProgressBarView(value: $viewModel.volume, range: 0...viewModel.totalVolume)
                            .frame(height: 3)
                            .padding(.horizontal, 20)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "speaker.wave.3.fill")
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal)
                    .foregroundStyle(.white)
                    .padding(.top)
                    
                    //Additional control buttons (e.g., lyrics, AirPods, playlist)
                    HStack(spacing: 80) {
                        Button {
                             //Action for showing lyrics or quotes
                            showingLyrics.toggle()
                        } label: {
                            Image(systemName: "quote.bubble")
                            
                        }.sheet(isPresented: $showingLyrics) {
                            if viewModel.currentMusic.lyric == "" {
                                Text("Lyrics not available")
                                    .presentationDetents([.medium])
                                     .presentationBackground(.ultraThinMaterial)
                                    .font(.subheadline)
                                    .bold()
                            } else {
                                ScrollView(.vertical) {
                                    Text(viewModel.currentMusic.lyric)
                                            .font(.subheadline)
                                            .bold()
                                            .presentationDetents([.medium])
                                            .presentationBackground(.ultraThinMaterial)
                                }
                                .padding([.top, .leading])
                            }
                        }
                        
                        Button {
                             //Action for connecting to AirPods or similar
                            airPodsSheet.toggle()
                        } label: {
                            Image(systemName: "airpods.gen4")
                        }.sheet(isPresented: $airPodsSheet) {
                            airPodsview()
                        }
                        
                        Button {
                             //Action for showing the playlist
                        } label: {
                            Image(systemName: "list.bullet")
                        }
                    }
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding(.top, 25)
                }
                .padding(.vertical)
                Spacer()
                
            }
        }
    }
    @ViewBuilder
    func airPodsview() -> some View {
        HStack {
            Spacer()
            Text("Kevin's AirPods Pro")
                .font(.title2)
                .bold()
            Spacer()
            Button {
                airPodsSheet.toggle()
            } label: {
                Image(systemName: "xmark")
                    .padding(.trailing)
            }
        }.padding(.top, 40)
        Spacer()
        VStack {
            Image("airPods_Pro")
                .resizable()
                .frame(width: 200, height: 200)
                .padding()
//                .rotation3DEffect(.degrees(is3DYRotating * 2), axis: (x: 0, y: is3DYRotating, z: 0))
//                .animation(.easeOut(duration: 6).repeatForever(autoreverses: false), value: is3DYRotating)
//                .onAppear {
//                    is3DYRotating = .random(in: 1...80)
//                }
            Image(systemName: "battery.75")
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(Color.green)
                
            Text("75 %")
                .font(.callout)
                .presentationDetents([.height(300)])
                .presentationBackground(.ultraThinMaterial)
        }
        Spacer()
    }
}

#Preview {
    AppleMusicPlayer()
}
