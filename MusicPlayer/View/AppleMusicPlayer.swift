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
    @EnvironmentObject var viewModel: AppleMusicViewModel
    
    @State var likeSheet: Bool = false
    @State var showingLyrics: Bool = false
    @State var airPodsSheet: Bool = false
    @State var playlistSheet: Bool = false
    
    var linearGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [viewModel.currentMusic.backgroundCover, .black]), startPoint: .top, endPoint: .bottom)
    }
    
    var body: some View {
        ZStack {
            //Background Gradient
              linearGradient
                    .ignoresSafeArea()
                    .animation(.easeInOut, value: viewModel.selectedMusic)
            
            VStack {
                //MARK: - Header
                HeaderView()
                
                //Album Artwork Image
                //MARK: - Artwork
                ArtworkView(likeSheet: $likeSheet)
                
                //MARK: - Player
                PlayerView()
                    
                //MARK: - Footer
                FooterView(showingLyrics: $showingLyrics, airPodsSheet: $airPodsSheet, playlistSheet: $playlistSheet)
                }
            }
        }
    }

#Preview {
    AppleMusicPlayer()
        .environmentObject(AppleMusicViewModel())
}
