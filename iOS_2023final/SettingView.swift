//
//  SettingView.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/17.
//

import SwiftUI

struct SettingView: View {
    @Binding var SettingOpen: Bool
    let RankStr = ["Easy", "Medium", "Hard"]
    @Binding var rank: Int
    @Binding var FaceIndex: Int
    let FaceIcons = ["figure.walk", "figure.run", "figure.roll.runningpace", "figure.core.training", "figure.disc.sports", "figure.gymnastics"]
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(Color(red: 1, green:1, blue:1))
                .frame(width:300, height:450)
                .cornerRadius(10)
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 10)
                .frame(width: 300, height: 450)
            // select Rank
            VStack {
                Text("Current Rank : ")
                    .foregroundColor(.black)
                    .bold()
                Text(RankStr[rank])
                    .font(.custom("SF Compact", size: 30))
                    .bold()
                    .foregroundColor(.blue)
                    .padding(10)
                    .border(Color.black, width: 3)
                    
                    
                Text("Select Rank")
                    .foregroundColor(.black)
                    .bold()
                HStack{
                    // Easy
                    Button{
                        self.rank = 0
                        print(rank)
                    } label: {
                        if self.rank == 0 {
                            Text("Easy")
                                .foregroundColor(.white)
                                .bold()
                                .padding(5)
                                .frame(width: 75, height:50)
                                .background(.red)
                                .border(Color.black, width: 3)
                                .cornerRadius(10)
                        } else {
                            Text("Easy")
                                .foregroundColor(.black)
                                .bold()
                                .padding(5)
                                .frame(width: 75, height:50)
                                .background(.green)
                                .border(Color.black, width: 3)
                                .cornerRadius(10)
                        }
                    }
                    // Medium
                    Button{
                        self.rank = 1
                        print(rank)
                    } label: {
                        if self.rank == 1 {
                            Text("Medium")
                                .foregroundColor(.white)
                                .bold()
                                .padding(5)
                                .frame(width: 75, height:50)
                                .background(.red)
                                .border(Color.black, width: 3)
                                .cornerRadius(10)
                        } else {
                            Text("Medium")
                                .foregroundColor(.blue)
                                .bold()
                                .padding(5)
                                .frame(width: 75, height:50)
                                .background(.green)
                                .border(Color.black, width: 3)
                                .cornerRadius(10)
                        }
                        
                    }
                    
                    Button{
                        self.rank = 2
                        print(rank)
                    } label: {
                        if self.rank == 2 {
                            Text("Hard")
                                .foregroundColor(.white)
                                .bold()
                                .padding(5)
                                .frame(width: 75, height:50)
                                .background(.red)
                                .border(Color.black, width: 3)
                                .cornerRadius(10)
                        } else {
                            Text("Hard")
                                .foregroundColor(.red)
                                .bold()
                                .padding(5)
                                .frame(width: 75, height:50)
                                .background(.green)
                                .border(Color.black, width: 3)
                                .cornerRadius(10)
                        }
                    }
                }
                Spacer()
                Text("Select Your FaceIcon :")
                    .foregroundColor(.black)
                    .bold()
                VStack{
                    HStack{
                        // image 0
                        ForEach(0..<3){item in
                            Button{
                                self.FaceIndex = item
                                print(FaceIndex)
                            } label: {
                                if self.FaceIndex == item {
                                    Image(systemName: FaceIcons[item])
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.blue)
                                        .frame(width: 40, height: 40)
                                        .padding()
                                } else {
                                    Image(systemName: FaceIcons[item])
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.green)
                                        .frame(width: 40, height: 40)
                                        .padding()
                                }
                                
                            }
                            
                        }
                        
                    }
                    HStack{
                        // image 3
                        ForEach(3..<6){item in
                            Button{
                                self.FaceIndex = item
                                print(FaceIndex)
                            } label: {
                                if self.FaceIndex == item {
                                    Image(systemName: FaceIcons[item])
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.blue)
                                        .frame(width: 40, height: 40)
                                        .padding()
                                } else {
                                    Image(systemName: FaceIcons[item])
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.green)
                                        .frame(width: 40, height: 40)
                                        .padding()
                                }
                            }
                        }
                    }
                }
            }.frame(width:300, height:400)
            // ===
            Button{
                SettingOpen = false
                print(SettingOpen)
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
        }.position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        @State var SettingOpenTest = false
        @State var rank: Int = 0
        @State var FaceIn: Int = 0
        SettingView(SettingOpen: $SettingOpenTest, rank: $rank, FaceIndex: $FaceIn)
    }
}
