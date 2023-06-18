//
//  LogInView.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/19.
//

import SwiftUI

struct LogInView: View {
    @State private var Logging: Bool = false
    @State private var rotationDegree: Double = 0
    @State private var diffDegree: Double = 3
    @State private var ScaleSize: CGFloat = 1
    @State private var diffSize: Double = 0.1
    @State private var ImageColor: Color = .blue
    @State var PlayerName: String = ""
    let TempTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if !Logging {
            ZStack{
                Image("gym")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.5)
                VStack {
                    Text("Welcome to")
                        .font(.custom("Nagurigaki Crayon", size: 60))
                        .padding(0)
                    Image("IconLogo")
                        .resizable()
                        .frame(width: 200, height: 150)
                        .onReceive(TempTimer){ _ in
                            if abs(rotationDegree - 30)<0.001 {
                                diffDegree = -abs(diffDegree)
                            }
                            if abs(rotationDegree + 30)<0.001 {
                                diffDegree = abs(diffDegree)
                            }
                            
                            if abs(ScaleSize-1.5)<0.001 {
                                diffSize = -abs(diffSize)
                            }
                            if abs(ScaleSize-0.5)<0.001 {
                                diffSize = abs(diffSize)
                            }
                            ScaleSize += diffSize
                            rotationDegree += diffDegree
                            ImageColor = Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
                        }
                        .scaleEffect(ScaleSize)
                        .rotationEffect(Angle(degrees: rotationDegree))
                        .animation(.default, value: rotationDegree)
                        .animation(.default, value: ScaleSize)
                        .padding(0)
                    
                    Image(systemName: "figure.strengthtraining.traditional")
                        .resizable()
                        .frame(width: 100, height: 120)
                        .foregroundColor(ImageColor)
                        .animation(.default, value: ImageColor)
                    
                    Text("Your Name：")
                        .padding()
                    TextField("PlayerName", text: $PlayerName, prompt: Text("Input your Name"))
                        .padding()
                        .autocapitalization(.none) // 禁用自動首字母大寫
                        .background()
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.black, lineWidth: 5)
                        )
                        .padding([.horizontal ,.bottom], 40)
                    
                    Button{
                        if !PlayerName.isEmpty{
                            Logging = true
                        }
                    } label: {
                        Text("Start Game")
                            .foregroundColor(.blue)
                            .bold()
                    }
                }
            }
        } else {
            MainGameView(PlayerName: $PlayerName)
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
                .ignoresSafeArea()
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}

