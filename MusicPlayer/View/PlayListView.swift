//
//  PlayListView.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 10/04/2025.
//

import SwiftUI

struct PlayListView: View {
    @EnvironmentObject var viewModel: AppleMusicViewModel
    
    var body: some View {
        // Vérifie si la LISTE des musiques likées est vide
        if viewModel.musicLiked.isEmpty {
            Text("Empty playlist")
        } else {
            // Si la liste n'est PAS vide, affiche la liste
            List {
                ForEach(viewModel.musicLiked) { playlist in
                    Text("\(playlist.artist) - \(playlist.title)")
                    if viewModel.isLiked == false {
//                        viewModel.removeItems()
                    }
                }
                .onDelete(perform: viewModel.removeItems)
            }
        }
    }
}

#Preview {
    PlayListView()
        .environmentObject(AppleMusicViewModel())
}
