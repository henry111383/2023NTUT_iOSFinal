//
//  HistoryScoreView.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/19.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct HistoryScoreView: View {
    @Binding var HistoryScoreOpen: Bool
    @FirestoreQuery(collectionPath: "HistoryScore") var historyScores: [HistoryScore]
    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red: 1, green:1, blue:1))
                .frame(width:300, height:450)
                .cornerRadius(10)
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 10)
                .frame(width: 300, height: 450)
            Button{
                HistoryScoreOpen = false
                print(HistoryScoreOpen)
            } label: {
                ZStack{
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                }
            }.offset(x:150, y:-225)
            VStack{
                ZStack{
                    Text("PushUp")
                        .foregroundColor(.black)
                        .font(.custom("Nagurigaki Crayon", size: 25))
                    Text("PushUp")
                        .foregroundColor(.green)
                        .font(.custom("Nagurigaki Crayon", size: 24))
                }
                ScrollView(.vertical){
                    ForEach(historyScores) { tempScore in
                        if tempScore.GameMode == "PushUp" {
                            HistoryScoreRow(historyScore: tempScore)
                        }
                    }
                }
                .frame(width: 270, height: 150)
//                .border(.black)
                .background(.gray)
                Spacer()
                ZStack{
                    Text("FaceOn")
                        .foregroundColor(.black)
                        .font(.custom("Nagurigaki Crayon", size: 25))
                    Text("FaceOn")
                        .foregroundColor(.red)
                        .font(.custom("Nagurigaki Crayon", size: 24))
                }
                ScrollView(.vertical){
                    ForEach(historyScores) { tempScore in
                        if tempScore.GameMode == "FaceOn" {
                            HistoryScoreRow(historyScore: tempScore)
                        }
                    }
                }
                .frame(width: 270, height: 150)
//                .border(.black)
                .background(.gray)
            }
            .frame(width:300, height:400)
        }.position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    }
}

struct HistoryScoreView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScoreView(HistoryScoreOpen: .constant(true))
    }
}
