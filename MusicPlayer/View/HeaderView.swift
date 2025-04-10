//
//  HeaderView.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 10/04/2025.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
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
    }
}

#Preview {
    HeaderView()
}
