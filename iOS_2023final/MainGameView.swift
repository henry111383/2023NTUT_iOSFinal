//
//  ContentView.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/2.
//

import SwiftUI
import AVFoundation

struct MainGameView: View {
    @Binding var PlayerName: String
    @State var isPlaying = false
    @State private var PushUpMaxScore: Int = 0
    @State private var FaceOnMaxScore: Int = 0
    @State var rank: Int = 0
    @State var PushUpSpeed = [0.04, 0.06, 0.09]
    @State var FaceOnSize = [200, 150, 100]
    @State var FaceIndex = 0
    @State var FaceIcons = ["figure.walk", "figure.run", "figure.roll.runningpace", "figure.core.training", "figure.disc.sports", "figure.gymnastics"]
    @State private var SettingOpen = false
    @State private var HistoryScoreOpen = false
    @State private var MusicOpen = false
    var MusicPlayer = AudioPlayer()
    var body: some View {
        ZStack{
            NavigationView {
                ZStack{
                    Color(red: 231/255, green: 204/255, blue:  255/255)
                        .ignoresSafeArea()
                    Image("IconLogo")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .position(x: UIScreen.main.bounds.width/2, y:30)
                    VStack{
                        NavigationLink {
                            FaceOnView(PlayerNameID: PlayerName, rankInt: rank, FaceOnMaxScore: $FaceOnMaxScore, figureStr: FaceIcons[FaceIndex], mask_length: CGFloat(FaceOnSize[rank]), mask_height: CGFloat(FaceOnSize[rank]))
                                .ignoresSafeArea(.all, edges: .all)
                        } label: {
                            PlayFaceOnButtonView()
                                .padding(.top, 50)
                        }.padding(.top, 50)
                        NavigationLink {
                            PushUpView(PlayerNameID: PlayerName, rankInt: rank, PushUpMaxScore: $PushUpMaxScore, speed: PushUpSpeed[rank], figureStr: FaceIcons[FaceIndex])
                                .ignoresSafeArea(.all, edges: .all)
                        } label: {
                            PlayPushUpButtonView()
                                .padding(0)
                        }
                        HStack{
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color.gray)
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(30)
                                Button{
                                    SettingOpen.toggle()
                                    HistoryScoreOpen = false
                                    print(SettingOpen)
                                } label: {
                                    Image(systemName: "gear")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.white)
                                }
                            }
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color.brown)
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(30)
                                Button{
                                    HistoryScoreOpen.toggle()
                                    SettingOpen = false
                                } label: {
                                    Image(systemName: "trophy")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.yellow)
                                }
                            }
                            
                            
                            ZStack{
                                Rectangle()
                                    .foregroundColor(Color.green)
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(30)
                                Button{
                                    MusicOpen.toggle()
                                    if MusicOpen {
                                        MusicPlayer.playAudio()
                                    } else {
                                        MusicPlayer.pauseAudio()
                                    }
                                    print(MusicOpen)
                                } label: {
                                    ZStack{
                                        Image(systemName: "music.note")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.white)
                                        if !MusicOpen {
                                            Rectangle()
                                                .foregroundColor(.red)
                                                .frame(width: 50, height: 10)
                                                .rotationEffect(Angle(degrees: 30))
                                            
                                        }
                                    }
                                    
                                }
                            }
                        }
                        .frame(width: 200, height: 100)
                        .padding(.top, 0)
                        
                    }.position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
                }
            }
            if SettingOpen {
                SettingView(SettingOpen: $SettingOpen, rank: $rank, FaceIndex: $FaceIndex)
            }
            if HistoryScoreOpen {
                HistoryScoreView(HistoryScoreOpen: $HistoryScoreOpen)
            }
        }
    }
}

struct MainGameView_Preview: PreviewProvider {
    static var previews: some View {
        MainGameView(PlayerName: .constant("John Doe"))
    }
}
