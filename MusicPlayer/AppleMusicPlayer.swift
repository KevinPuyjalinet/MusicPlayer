//
//  AppleMusicPlayer.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 08/04/2025.
//

import SwiftUI
import MediaPlayer

struct AppleMusicPlayer: View {
    //MARK: - State Variable
    @StateObject var viewModel = AppleMusicViewModel()
    @State private var likeSheet: Bool = false
    @State private var showingLyrics: Bool = false
    @State private var airPodsSheet: Bool = false
    @State private var playlistSheet: Bool = false
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
                //MARK: - Header
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
                //MARK: - Artwork
                TabView(selection: $viewModel.selectedMusic) {
                    ForEach(viewModel.musicData.indices, id: \.self) { index in
                        let music = viewModel.musicData[index]
                        Image(music.cover)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 300, height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.top, 60)
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
                        
                    }.onChange(of: viewModel.currentMusic, {
                        viewModel.isLiked = false
                    })
                    .sheet(isPresented: $likeSheet) {
                        VStack(spacing: 5) {
                            Text(viewModel.isLiked ? "Musique ajouté en favoris" : "Musique supprimer en favoris")
                                .presentationDetents([.height(40)])
                                .presentationBackground(.ultraThinMaterial)
                        }
                    }
                    
                    //More option button with background circle
                    Menu {
                        //Action for additing options
                        Button("Option 1", action: { print("Option 1") })
                        Button("Option 2", action: { print("Option 2") })
                       
                    } label: {
                        Image(systemName: "ellipsis.circle")
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
                
                //MARK: - Player
                
                //Playback progress bar with current time and total time labels
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
                            viewModel.backForward(by: viewModel.totalTime)
                        } label: {
                            Image(systemName: "backward.fill")
                                .font(.title2)
                        }
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
                        } label: {
                            Image(systemName: "forward.fill")
                                .font(.title2)
                        }
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
                    
                    //MARK: - Footer
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
                                    .presentationDetents([.height(300)])
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
                            playlistSheet.toggle()
                        } label: {
                            Image(systemName: "list.bullet")
                        }.sheet(isPresented: $playlistSheet) {
                            playlistview()
                                .presentationDetents([.height(300)])
                                .presentationBackground(.ultraThinMaterial)
                                .font(.subheadline)
                                .bold()
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
    @ViewBuilder
    func playlistview() -> some View {
            if viewModel.isLiked {
                List {
                    Text("\(viewModel.currentMusic.artist) - \(viewModel.currentMusic.title)")
                }
            } else {
                Text("Empty playlist")
        }
    }
}

#Preview {
    AppleMusicPlayer()
}
