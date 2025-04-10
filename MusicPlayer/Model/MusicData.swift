//
//  MusicData.swift
//  MusicPlayer
//
//  Created by Kévin PUYJALINET on 07/04/2025.
//

import Foundation
import SwiftUI

struct MusicData: Identifiable, Equatable {
    let id: UUID = .init()
    let cover: String
    let artist: String
    let title: String
    let lyric: String
    let backgroundCover: Color
    let music: String
}

var sampleMusicData: [MusicData] = [
    .init(cover: "jongho", artist: "Jongho Baek", title: "Sphere", lyric: "", backgroundCover: .purple, music: "jongho"),
    .init(cover: "keenv", artist: "Keen'V", title: "Monde Meilleur", lyric: "Dans un monde meilleur\nOn pourrait tous effacer\nLes erreurs du passé\nQui empêchent d'avancer\n\nDans un monde meilleur\nOn n'jugerait pas sur l'aspect\nOn vivrait tous en paix\nEnsemble dans le respect\n\nOui dans un monde meilleur\nC'est l'amour qui nous guidera\nEt l'on s'entraidera\nOui cela se fera\n\nDans un monde meilleur\nEnsemble on bâtira\nUn monde pour toi et moi\nOu chacun de nous vivra\n\nOui dans un monde meilleur\nPa-la-pa-la-pa-pa-pa-la\nPa-la-pa-la-pa-pa-pa-la\nPa-la-pa-la-pa-pa-pa-la\n\nDans un monde meilleur\nPa-la-pa-la-pa-pa-pa-la\nPa-la-pa-la-pa-pa-pa-la\nPa-la-pa-la-pa-pa-pa-la\n\nLe monde meilleur serait sans drames\nSerait sans peurs, serait sans larmes\nChacun ferait ce qui lui plaît\nSans que personne ne vienne et le blâme\n\nOn pourrait arrêter le temps quand on veut\nPour mieux profiter de l'instant\nOn pourrait voyager, exaucer ses vœux\nSeulement en se téléportant\n\nOn s'emmerderait pas d'un taf ennuyeux\nOn vivrait c'qui nous semble important\nOn profiterait tant qu'on est vivant\n\nDans un monde meilleur\nOn pourrait tous effacer\nLes erreurs du passé\nQui empêchent d'avancer\nDans un monde meilleur\nOn n'jugerait pas sur l'aspect\nOn vivrait tous en paix\nEnsemble dans le respect\n\nOui dans un monde meilleur\nC'est l'amour qui nous guidera\nEt l'on s'entraidera\nOui cela se fera\n\nDans un monde meilleur\nEnsemble on bâtira\nUn monde pour toi et moi\nOu chacun de nous vivra\n\nOui dans un monde meilleur\nPa-la-pa-la-pa-pa-pa-la\nPa-la-pa-la-pa-pa-pa-la\nPa-la-pa-la-pa-pa-pa-la\n\nDans un monde meilleur\nPa-la-pa-la-pa-pa-pa-la\nPa-la-pa-la-pa-pa-pa-la\nPa-la-pa-la-pa-pa-pa-la\n\nDans ce monde chacune de nos prières serait exaucée\nEt l'on vivrait selon nos envies\n\nPersonne n'aurait à exister avec des regrets\nEt John Snow serait en vie\n\nDis-toi que tout serait possible\nQue tout serait, tout serait possible\nChaque mère serait une reine\n\nDis-toi que tout serait possible\nQue tout serait, tout serait possible\nSi l'on s'en donnait la peine\n\nDans un monde meilleur\nOn pourrait tous effacer\nLes erreurs du passé\nQui empêchent d'avancer\n\nDans un monde meilleur\nOn n'jugerait pas sur l'aspect\nOn vivrait tous en paix\nEnsemble dans le respect\n\nOui dans un monde meilleur\nC'est l'amour qui nous guidera\nEt l'on s'entraidera\nOui cela se fera\n\nDans un monde meilleur\nEnsemble on bâtira\nUn monde pour toi et moi\nOu chacun de nous vivra\n\nOui dans un monde meilleur\nPa-la-pa-la-pa-pa-pa-la (dans un monde meilleur)\nPa-la-pa-la-pa-pa-pa-la (dans un monde meilleur)\nPa-la-pa-la-pa-pa-pa-la (en un Mundo mejor)\nPa-la-pa-la-pa-pa-pa-la\nPa-la-pa-la-pa-pa-pa-la (em um mundo melhor)\nPa-la-pa-la-pa-pa-pa-la\n\nDans un monde meilleur", backgroundCover: .keenv, music: "keenv"),
    .init(cover: "shakira", artist: "Shakira", title: "She Wolf", lyric: "", backgroundCover: .shakira, music: "shakira"),
    .init(cover: "david", artist: "DaviD", title: "Drapeau", lyric: "", backgroundCover: .david, music: "david")
]

