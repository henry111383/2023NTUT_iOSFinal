//
//  HistoryScoreRow.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/19.
//

import SwiftUI

struct HistoryScoreRow: View {
    let historyScore: HistoryScore
    var body: some View {
        HStack {
            VStack{
                Text(historyScore.Time, style: .date)
                    .font(.custom("Nagurigaki Crayon", size: 12))
                    .foregroundColor(.black)
                Text(historyScore.Time, style: .time)
                    .font(.custom("Nagurigaki Crayon", size: 12))
                    .foregroundColor(.black)
            }.frame(width: 50)
            Image(systemName: historyScore.IconStr)
                .resizable()
                .scaledToFit()
                .clipped()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
                .padding(10)
            VStack(alignment: .leading) {
                Text(historyScore.PlayerNameID)
                    .font(.custom("Nagurigaki Crayon", size: 18))
                    .foregroundColor(.black)
                    .bold()
                Text(historyScore.GameMode)
                    .font(.custom("Nagurigaki Crayon", size: 12))
                    .foregroundColor(.black)
            }.frame(width: 70)
            VStack{
                Text("\(historyScore.RankMode) Mode")
                    .font(.custom("Nagurigaki Crayon", size: 12))
                    .foregroundColor(.black)
                Text(String(historyScore.GameScore))
                    .font(.custom("Nagurigaki Crayon", size: 18))
                    .foregroundColor(.black)
            }.frame(width: 70)
        }
        .padding(5)
        .background(Color.white)
        .cornerRadius(20)
        .overlay(
                     RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.blue, lineWidth: 2)
                  )
    }
}

struct HistoryScoreRow_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScoreRow(historyScore: HistoryScore.demoPushUp)
    }
}
