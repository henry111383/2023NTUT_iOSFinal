//
//  PlayPushUpVButtonView.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/15.
//

import SwiftUI

struct PlayPushUpVButtonView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red: 0.1, green: 0.8, blue: 0.6))
                .frame(width: 100, height: 40)
                .offset(x:-20, y:-110)
                .rotationEffect(Angle(degrees: -30))
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 200, height: 200)
                .cornerRadius(20)
            Rectangle()
                .stroke(Color.black, lineWidth: 4)
                            .frame(width: 150, height: 150)
            Image("PushUpIcon")
                .resizable()
                .frame(width: 150, height: 150)
            ZStack{
                Rectangle()
                    .foregroundColor(Color(red: 0.1, green: 0.8, blue: 0.6))
                    .frame(width: 100, height: 40)
                Text("PushUp")
                    .foregroundColor(.red)
                    .font(.custom("SF Compact", size: 20))
            }.offset(x:-70, y:-50)
                
        }
    }
}

struct PlayPushUpVButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayPushUpVButtonView()
    }
}
