//
//  HistoryScore.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/19.
//

import Foundation
import FirebaseFirestoreSwift

struct HistoryScore:  Codable, Identifiable {
    @DocumentID var id: String?
    let PlayerNameID: String
    let GameMode: String
    let RankMode: String
    let GameScore: Int
    let IconStr: String
    let Time: Date
}

extension HistoryScore {
    static let demoPushUp = HistoryScore(PlayerNameID: "Peter", GameMode: "PushUp", RankMode: "Hard", GameScore: 20, IconStr: "figure.run", Time: Date())
    static let demoFaceUp = HistoryScore(PlayerNameID: "Rose", GameMode: "FaceOn", RankMode: "Easy", GameScore: 100, IconStr: "figure.gymnastics", Time: Date())
}
