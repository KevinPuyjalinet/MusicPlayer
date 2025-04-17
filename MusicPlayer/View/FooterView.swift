//
//  FooterView.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 10/04/2025.
//

import SwiftUI

struct FooterView: View {
    @EnvironmentObject var viewModel: AppleMusicViewModel
    @Binding var showingLyrics: Bool
    @Binding var airPodsSheet: Bool
    @Binding var playlistSheet: Bool
    var body: some View {
        HStack(spacing: 80) {
            Button {
                 //Action for showing lyrics or quotes
                showingLyrics.toggle()
            } label: {
                Image(systemName: "quote.bubble")
                
            }.sheet(isPresented: $showingLyrics) {
                if viewModel.currentMusic().lyric == "" {
                    Text("Lyrics not available")
                        .presentationDetents([.height(300)])
                         .presentationBackground(.ultraThinMaterial)
                        .font(.subheadline)
                        .bold()
                } else {
                    ScrollView(.vertical) {
                        Text(viewModel.currentMusic().lyric)
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
                AirPodsView(airPodsSheet: $airPodsSheet)
            }
            
            Button {
                 //Action for showing the playlist
                playlistSheet.toggle()
            } label: {
                Image(systemName: "list.bullet")
            }.sheet(isPresented: $playlistSheet) {
                PlayListView()
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
}

#Preview {
    FooterView(showingLyrics: .constant(false), airPodsSheet: .constant(false), playlistSheet: .constant(false))
}
