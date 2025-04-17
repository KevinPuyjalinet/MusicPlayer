//
//  ArtworkView.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 10/04/2025.
//

import SwiftUI

struct ArtworkView: View {
    @EnvironmentObject var viewModel: AppleMusicViewModel
    @Binding var likeSheet: Bool
    var body: some View {
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
                Text(viewModel.currentMusic().title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Text(viewModel.currentMusic().artist)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
            }
            .animation(.easeInOut, value: viewModel.selectedMusic)
            
            Spacer()
            Button {
                // Like button Toggling Between liked unliked state
//                viewModel.toggleLike()
                viewModel.isLiked.toggle()
                likeSheet.toggle()
                viewModel.successFeedback()
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
                
            }.onChange(of: viewModel.currentMusic()) {
                viewModel.updateIsLikedState()
            }
            .sheet(isPresented: $likeSheet) {
                sheetLikedView(viewModel: viewModel)
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
    }
}

@ViewBuilder
func sheetLikedView(viewModel: AppleMusicViewModel) -> some View {
    VStack(spacing: 5) {
        Text(viewModel.isLiked ? "Musique ajouté en favoris" : "Musique supprimer en favoris")
            .presentationDetents([.height(40)])
            .presentationBackground(.ultraThinMaterial)
    }
}

#Preview {
    ArtworkView(likeSheet: .constant(false))
        .environmentObject(AppleMusicViewModel())
}
