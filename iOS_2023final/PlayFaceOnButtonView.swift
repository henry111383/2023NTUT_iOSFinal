//
//  PlayFaceOnButtonView.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/15.
//

import SwiftUI

struct PlayFaceOnButtonView: View {
    var body: some View {
        ZStack{
            
            Rectangle()
                .foregroundColor(Color(red: 0.1, green: 0.8, blue: 0.9))
                .frame(width: 200, height: 200)
                .cornerRadius(20)
            Rectangle()
                .foregroundColor(Color(red: 04, green: 0.6, blue: 0.6))
                .frame(width: 50, height: 40)
                .offset(x:-80, y:-70)
                .rotationEffect(Angle(degrees: -10))
            Rectangle()
                .stroke(Color.black, lineWidth: 4)
                            .frame(width: 150, height: 150)
            Image("FaceOnIcon")
                .resizable()
                .frame(width: 150, height: 150)
            ZStack{
                Rectangle()
                    .foregroundColor(Color(red: 04, green: 0.6, blue: 0.6))
                    .frame(width: 100, height: 40)
                Text("FaceOn")
                    .foregroundColor(.black)
                    .font(.custom("Nagurigaki Crayon", size: 25))
                Text("FaceOn")
                    .foregroundColor(.white)
                    .font(.custom("Nagurigaki Crayon", size: 24))
            }.offset(x:-70, y:-50)
                
        }
    }
}


struct PlayFaceOnButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayFaceOnButtonView()
    }
}
