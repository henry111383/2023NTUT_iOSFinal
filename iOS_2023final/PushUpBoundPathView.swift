//
//  PushUpPathView.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/14.
//

import SwiftUI

struct PushUpPathBoundView: View {

    
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .position(x: UIScreen.main.bounds.width/2, y: -220)
                .opacity(0.8)
            BoundView(ImageColor: Color.red)
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 + 200)
            BoundView(ImageColor: Color.red)
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - 200)
            Rectangle()
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height + 220)
                .opacity(0.8)
            
        }
    }
}

struct BoundView: View {
    let ImageColor: Color
    var body: some View {
        Rectangle()
            .foregroundColor(ImageColor)
            .frame(width: UIScreen.main.bounds.width, height: 10)
            .background(.black)
            .opacity(0.9)
    }
}

struct PushUpPathView_Previews: PreviewProvider {
    static var previews: some View {
        PushUpPathBoundView()
    }
}
