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
    PlayListView()
        .environmentObject(AppleMusicViewModel())
}
