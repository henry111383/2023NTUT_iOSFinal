//
//  PushUpPathView.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/14.
//

import SwiftUI

struct PushUpPathView: View {
    var length = CGFloat.random(in: 100...300)
    
    var body: some View {
        ZStack{
            BoundView()
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 + 200)
            BoundView()
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2 - 200)
            CactusView(length: length, durationTime: 1)
        }
    }
}

struct BoundView: View {
    var body: some View {
        Text("")
            .frame(width: UIScreen.main.bounds.width, height: 10)
            .background(.black)
            .opacity(0.9)
    }
}

struct PushUpPathView_Previews: PreviewProvider {
    static var previews: some View {
        PushUpPathView()
    }
}
