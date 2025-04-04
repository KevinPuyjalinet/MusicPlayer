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

struct AppleMusicPlayer: View {
    //MARK: - State Variable
    @State private var isPlaying: Bool = false
    @State private var currentTime: Double = 120
    @State private var volume: Double = 0.5
    @State private var totalVolume: Double = 1
    @State private var isLiked: Bool = false
    @State private var showingLyrics: Bool = false
    private let totalTime: Double = 240
    private let albumArtSize: CGFloat = UIScreen.main.bounds.width - 40
    
    var body: some View {
        ZStack {
            //Background Gradient
            LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
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
                Image("album_cover")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.top, 40)
                    .padding(.bottom, 40)
                    .shadow(color: .black, radius: 5, x: 0, y: 5)
                
                    //Song information and like/more options
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Sphere")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        
                        Text("Jongho Baek")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
                    Button {
                        // Like button Toggling Between liked.unliked state
                        isLiked.toggle()
                    } label: {
                        Image(systemName: isLiked ? "star.circle.fill" : "star.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(isLiked ? .yellow : .white)
                            .imageScale(.large)
                            .contentTransition(.symbolEffect(.replace.magic(fallback: .downUp.byLayer), options: .nonRepeating))
                    }
                    
                    //More option button with background circle
                    Button {
                        //Action for additing options
                    } label: {
                    
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.white)
                                .imageScale(.large)
                    }
                    .padding(10)
                    .background(Circle().foregroundStyle(Color.white.opacity(0.1)))
                }
                .padding(.horizontal)
                .padding(.top)
                .padding(.bottom, 50)
                
                //Playback progress bar with current time and total time labels
                VStack {
                        customProgressBarView(value: $currentTime, range: 0...totalTime)
                        .frame(height: 3)
                        .padding(.horizontal)
                    
                    HStack {
                        Text(timeString(time: currentTime))
                        Spacer()
                        Text(timeString(time: totalTime))
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
                            togglePlay()
                        } label: {
                            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
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
                        
                        customProgressBarView(value: $volume, range: 0...totalVolume)
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
                            Text("")
                                .presentationDetents([.medium, .large])
                        }.preferredColorScheme(.dark)
                        
                        Button {
                             //Action for connecting to AirPods or similar
                        } label: {
                            Image(systemName: "airpods.gen4")
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
    
    //Toggle the play/pause state with spring animation
    private func togglePlay() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
            isPlaying.toggle()
        }
    }
    
    // Format a time value (in seconds) to a string in "m:ss" format
    private func timeString(time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
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
