//
//  AirPodsView.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 10/04/2025.
//

import SwiftUI

struct AirPodsView: View {
    @Binding var airPodsSheet: Bool
    var body: some View {
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
}

#Preview {
    AirPodsView(airPodsSheet: .constant(false))
}
