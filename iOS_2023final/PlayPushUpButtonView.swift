//
//  PlayPushUpVButtonView.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/15.
//

import SwiftUI

struct PlayPushUpButtonView: View {
    var body: some View {
        ZStack{
            
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 200, height: 200)
                .cornerRadius(20)
            Rectangle()
                .foregroundColor(Color(red: 0.1, green: 0.8, blue: 0.6))
                .frame(width: 50, height: 40)
                .offset(x:-80, y:-70)
                .rotationEffect(Angle(degrees: -10))
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
                    .foregroundColor(.black)
                    .font(.custom("Nagurigaki Crayon", size: 25))
                Text("PushUp")
                    .foregroundColor(.white)
                    .font(.custom("Nagurigaki Crayon", size: 24))
            }.offset(x:-70, y:-50)
                
        }
    }
}

struct PlayPushUpVButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayPushUpButtonView()
    }
}
