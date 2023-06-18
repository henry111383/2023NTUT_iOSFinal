//
//  UpdateScore.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/19.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

func UpdateScore(PlayerNameID: String, GameMode: String, RankMode: String, GameScore: Int, IconStr: String, Time: Date){
    let db = Firestore.firestore()
    let new_historyScore = HistoryScore(PlayerNameID: PlayerNameID, GameMode: GameMode, RankMode: RankMode, GameScore: GameScore, IconStr: IconStr, Time: Time)
    
    do {
        _ = try db.collection("HistoryScore").addDocument(from: new_historyScore)
    } catch {
        print(error)
    }
}
