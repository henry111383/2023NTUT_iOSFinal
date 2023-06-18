import AVFoundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


struct FaceOnView:View {
    let PlayerNameID: String
    let rankInt: Int
    let RankStr = ["Easy", "Medium", "Hard"]
    @Binding var FaceOnMaxScore: Int
    @StateObject var camera = FaceOnCameraModel(FaceHeight: UIScreen.main.bounds.height/2)
    @Environment(\.presentationMode) var presentationMode
    let figureStr : String
    let mask_length: CGFloat
    let mask_height: CGFloat
    @State private var GameOver: Bool = false
    @State private var Score = 0
    let CountTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var TimeCount = 6
    let PrepareTimer = Timer.publish(every: 0.7, on: .main, in: .common).autoconnect()
    @State private var PrepareCount = 3
    @State private var GameTime = 3
    @State private var IsStartGame: Bool = false
    @State private var OffSetX: CGFloat = 0
    @State private var OffSetY: CGFloat = 0

    
    var body: some View{
        NavigationView {
            if !GameOver {
                ZStack{
                    FaceOnCameraPreview(camera: camera)
                        .ignoresSafeArea(.all, edges: .all)
                    FaceOnCircleView(faceY: camera.FaceHeight, faceX: camera.FaceX, figureStr: figureStr)
                    MaskView(MaskLength: mask_length, MaskHeight: mask_height)
                        .offset(x: OffSetX, y: OffSetY)
                    VStack{
                        ZStack{
                            Text("FaceOn")
                                .foregroundColor(.blue)
                                .font(.custom("SF Compact", size: 40))
                            Text("FaceOn")
                                .foregroundColor(.white)
                                .font(.custom("SF Compact", size: 38))
                            
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 0)
                        
                        Text("Keep Your Face in Orange Region!")
                            .padding(.top, 3)
                            .foregroundColor(.red)
                        HStack{
                            Text(" Score: ")
                            Text(String(Score))
                        }
                        .frame(width: 250)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(50)
                        //                .onReceive(ScoreTimer){ _ in
                        //                    if StartGame {
                        //                        Score += 1
                        //                    }
                        //                }
                        .padding(0)
                        Spacer()
                    }
                    if !IsStartGame {
                        if  TimeCount <= 3 {
                            ZStack{
                                if TimeCount > 1 {
                                    Text("Ready")
                                        .font(.system(size: 120))
                                        .bold()
                                        .foregroundColor(.black)
                                    Text("Ready")
                                        .font(.system(size: 110))
                                        .bold()
                                        .foregroundColor(.white)
                                } else {
                                    Text("Go")
                                        .font(.system(size: 120))
                                        .bold()
                                        .foregroundColor(.black)
                                    Text("Go")
                                        .font(.system(size: 110))
                                        .bold()
                                        .foregroundColor(.white)
                                }
                            }
                            .onReceive(CountTimer){ _ in
                                TimeCount -= 1
                                if TimeCount == 0 {
                                    IsStartGame = true
                                    SetMaskPosition()
                                }
                            }
                        }else{
                            ZStack{
                                Text(String(TimeCount-3))
                                    .font(.system(size: 120))
                                    .bold()
                                    .foregroundColor(.black)
                                Text(String(TimeCount-3))
                                    .font(.system(size: 110))
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            .onReceive(CountTimer){ _ in
                                TimeCount -= 1
                            }
                        }
                    } else { // IsGameStart == true
                        ZStack{
                            Text(String(PrepareCount))
                                .font(.system(size: 120))
                                .bold()
                                .foregroundColor(.white)
                            Text(String(PrepareCount))
                                .font(.system(size: 110))
                                .bold()
                                .foregroundColor(.red)
                        }
                        .onReceive(PrepareTimer){ _ in
                            PrepareCount -= 1
                            if PrepareCount == 0 {
                                CheckFaceInRegion()
                                PrepareCount = 3
                                SetMaskPosition()
                            }
                        }
                    }
                }
                .onAppear(perform: {
                    camera.Check()
                    })
            } else {
                ZStack{
                    Color.white.ignoresSafeArea()
                    VStack {
                        VStack {
                            Text("Game")
                                .font(.custom("SF Compact", size: 80))
                                .bold()
                                .foregroundColor(.black)
                            Text("Over")
                                .font(.custom("SF Compact", size: 80))
                                .bold()
                                .foregroundColor(.black)
                        }.onAppear{
                            if Score > FaceOnMaxScore {
                                FaceOnMaxScore = Score
                            }
                        }
                        HStack {
                            VStack {
                                HStack {
                                    Text(" Score: ")
                                    Text(String(Score))
                                }
                                .frame(width: 200)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding(10)
                                .background(.blue)
                                .cornerRadius(50)
                                HStack {
                                    Text(" Record: ")
                                    Text(String(FaceOnMaxScore))
                                }
                                .frame(width: 200)
                                .font(.title)
                                .bold()
                                .foregroundColor(.white)
                                .padding(10)
                                .background(.blue)
                                .cornerRadius(50)
                            }
                        }.padding(30)
                        HStack {
                            Button {
                                // update Firebase
                                UpdateScore(PlayerNameID: PlayerNameID, GameMode: "FaceOn", RankMode: RankStr[rankInt], GameScore: Score, IconStr: figureStr, Time: Date())
                                // Back to last page
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "arrowshape.turn.up.left.2.circle")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                            }
                        }
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    
    func SetMaskPosition() {
        self.OffSetX = CGFloat.random(in: -UIScreen.main.bounds.width/2+50...UIScreen.main.bounds.width/2-50)
        self.OffSetY = CGFloat.random(in: -UIScreen.main.bounds.height/2+200...UIScreen.main.bounds.height/2-50)
    }
    
    func CheckFaceInRegion() {
        let x1 = UIScreen.main.bounds.width/2 + self.OffSetX - self.mask_length/2
        let y1 = UIScreen.main.bounds.height/2 + self.OffSetY - self.mask_height/2
        let x2 = UIScreen.main.bounds.width/2 + self.OffSetX + self.mask_length/2
        let y2 = UIScreen.main.bounds.height/2 + self.OffSetY + self.mask_height/2
        let FaceX = UIScreen.main.bounds.width*camera.FaceX
        let FaceY = UIScreen.main.bounds.height*camera.FaceHeight
        
        if FaceY >= y1 && FaceY <= y2 {
            if FaceX >= x1 && FaceX <= x2 {
                self.Score += 1
                print("OK")
            } else { // GameOver
                GameOver = true
                print("Fail")
                return
            }
        } else { // GameOver
            print("Fail")
            GameOver = true
            return
        }
            
            
    }
}

struct MaskView: View{
//    let MaskX1 : CGFloat
//    let MaskY1 : CGFloat
    let MaskLength : CGFloat
    let MaskHeight : CGFloat
    
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.orange, lineWidth: 2)
                .frame(width: MaskLength, height: MaskHeight)
                .opacity(0.7)
            
            Group{
                // horizontal
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: MaskLength, height: 2)
                    .offset(y:(1/6)*MaskHeight)
                    .opacity(0.7)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: MaskLength, height: 2)
                    .offset(y:-(1/6)*MaskHeight)
                    .opacity(0.7)
                // verticle
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 2, height: MaskHeight)
                    .offset(x:(1/6)*MaskLength)
                    .opacity(0.7)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 2, height: MaskHeight)
                    .offset(x:-(1/6)*MaskLength)
                    .opacity(0.7)
            }
            Group{
                // corner(top-right)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 15, height: 4)
                    .offset(x:(1/2)*MaskLength-5, y:-(1/2)*MaskHeight-3)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 4, height: 15)
                    .offset(x:(1/2)*MaskLength+2, y:-(1/2)*MaskHeight+3)
                // corner(bottom-right)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 15, height: 4)
                    .offset(x:(1/2)*MaskLength-5, y:(1/2)*MaskHeight+3)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 4, height: 15)
                    .offset(x:(1/2)*MaskLength+2, y:(1/2)*MaskHeight-3)
                // corner(top-left)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 15, height: 4)
                    .offset(x:-(1/2)*MaskLength+5, y:-(1/2)*MaskHeight-3)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 4, height: 15)
                    .offset(x:-(1/2)*MaskLength-2, y:-(1/2)*MaskHeight+3)
                // corner(bottom-left)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 15, height: 4)
                    .offset(x:-(1/2)*MaskLength+5, y:(1/2)*MaskHeight+3)
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 4, height: 15)
                    .offset(x:-(1/2)*MaskLength-2, y:(1/2)*MaskHeight-3)
            }
            
                
        }
    }
}


struct FaceOnCameraPreview : UIViewRepresentable {
    @ObservedObject var camera : FaceOnCameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        camera.session.startRunning()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        return
    }
}

struct FaceOnCircleView: View {
    let faceY: CGFloat
    let faceX: CGFloat
    let figureStr: String
    var body: some View {
        ZStack {
            Image(systemName: figureStr)
                .resizable()
                .scaledToFit()
                .foregroundColor(.blue)
                .frame(width: 25, height: 25)
                .position(x:UIScreen.main.bounds.width*faceX, y: UIScreen.main.bounds.height*faceY)
        }
    }
}
