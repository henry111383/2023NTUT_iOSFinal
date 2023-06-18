import SwiftUI
import AVFoundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


struct PushUpView:View {
    let PlayerNameID: String
    let rankInt: Int
    let RankStr = ["Easy", "Medium", "Hard"]
    @Binding var PushUpMaxScore: Int
    @Environment(\.presentationMode) var presentationMode
    @StateObject var camera = PushUpCameraModel(FaceHeight: UIScreen.main.bounds.height/2)
    @State private var StartGame: Bool = false
    @State private var GameOver: Bool = false
    @State private var TimeCount = 6
    @State private var cactusFrame: CGRect = .zero
    @State private var Score = 0
    let ScoreTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let miniSecTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var CactusStyle1 = Int.random(in: 0...2)
    @State var CactusStyle2 = Int.random(in: 0...1)
    @State var center = CGFloat.random(in: 100...300)
    @State var FaceX : CGFloat = -150*cos(0)
    @State var TimeSecond = 0.0
    let speed : Double
    let figureStr : String
    

    var body: some View{
        NavigationView {
            if !GameOver{
                ZStack{
                    GeometryReader{ geometry in
                        ZStack{
                            PushUpCameraPreview(camera: camera)
                                .ignoresSafeArea(.all, edges: .all)
                            FaceCircleView(facePosition: camera.FaceHeight, figureStr: figureStr)
                                .offset(x: FaceX)
                                .onReceive(miniSecTimer){ _ in
                                    TimeSecond += speed
                                    FaceX = -150*cos(TimeSecond)
                                    if StartGame {
                                        GameOver = CheckCollision()
                                    }
                                }
                        }
                        .onAppear(perform: {
                            camera.Check()
                        })
                    }
                    if !GameOver {
                        PushUpPathBoundView()
                        
                        
                        CactusView(length: center - 50, styleRand: CactusStyle1, IsReverse: 0)
                            .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
                        HStack{
                            CactusView(length: 375 - center, styleRand: CactusStyle1, IsReverse: 1)
                            CactusView(length: 350 - center, styleRand: CactusStyle2, IsReverse: 1)
                            CactusView(length: 375 - center, styleRand: CactusStyle1, IsReverse: 1)
                        }
                        .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
                        
                        VStack{
                            ZStack{
                                Text("PushUp")
                                    .foregroundColor(.blue)
                                    .font(.custom("SF Compact", size: 40))
                                Text("PushUp")
                                    .foregroundColor(.white)
                                    .font(.custom("SF Compact", size: 38))
                                
                            }
                            .padding(.top, 10)
                            .padding(.bottom, 0)
                            
                            Text("Keep Your Face in Safe Region!")
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
                            .onReceive(ScoreTimer){ _ in
                                if StartGame {
                                    Score += 1
                                }
                            }
                            .padding(0)
                            Spacer()
                        }
                        
                        if !StartGame {
                            if TimeCount <= 3 {
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
                                .onReceive(ScoreTimer){ _ in
                                    TimeCount -= 1
                                    if TimeCount == 0 {
                                        StartGame = true
                                        TimeSecond = 0
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
                                .onReceive(ScoreTimer){ _ in
                                    TimeCount -= 1
                                }
                            }
                        }
                    }
                }
            } else { // GameOverView
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
                            if Score > PushUpMaxScore {
                                PushUpMaxScore = Score
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
                                    Text(String(PushUpMaxScore))
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
                                UpdateScore(PlayerNameID: PlayerNameID, GameMode: "PushUp", RankMode: RankStr[rankInt], GameScore: Score, IconStr: figureStr, Time: Date())
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
    
    
    func PlayAgain() {
        // 重置遊戲相關的狀態和變數
        StartGame = false
        GameOver = false
        TimeCount = 3
        Score = 0
        CactusStyle1 = Int.random(in: 0...2)
        CactusStyle2 = Int.random(in: 0...1)
        center = CGFloat.random(in: 100...300)
        FaceX = -150 * cos(0)
        TimeSecond = 0.0
    }

    func CheckCollision() -> Bool {
        let Checked_Y = UIScreen.main.bounds.height * camera.FaceHeight
        let DownCenterY = UIScreen.main.bounds.height/2 + 200 - (center - 50)
        let UpCenterY = UIScreen.main.bounds.height/2 - 200 + (350 - center)
        let DownBoundY = UIScreen.main.bounds.height/2 + 200
        let UpBoundY = UIScreen.main.bounds.height/2 - 200 + (375 - center)
        if StartGame {
            if abs(FaceX) <= 50 {
                // Center
                if abs(FaceX) <= 50 && ( (Checked_Y >= DownCenterY) || (Checked_Y <= UpCenterY) ) {
                    return true
                }
            } else {
                // Bound
                if ( (Checked_Y >= DownBoundY) || (Checked_Y <= UpBoundY) ) {
                    return true
                }
            }
        }
        return false
    }
}




struct PushUpCameraPreview : UIViewRepresentable {
    @ObservedObject var camera : PushUpCameraModel
    
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

struct FaceCircleView: View {
    let facePosition: CGFloat
    let figureStr: String
    var body: some View {
        ZStack {
            Image(systemName: figureStr)
                .resizable()
                .scaledToFit()
                .foregroundColor(.blue)
                .frame(width: 25, height: 25)
                .position(x:UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height*facePosition)
        }
    }
}

struct CactusView: View {
    var length: CGFloat
    var styleRand: Int
    var styleArr = ["cactus_1", "cactus_2", "cactus_3"]
    var IsReverse: Int
    var body: some View {
        VStack{
            if IsReverse == 0 {
                VStack{
                    Spacer()
                    Image(styleArr[styleRand])
                        .resizable()
                        .frame(width: 100, height: length)
                        .opacity(0.9)
                        .foregroundColor(.red)
                }
            } else {
                VStack{
                    Image(styleArr[styleRand])
                        .resizable()
                        .scaleEffect(x: 1, y:-1)
                        .frame(width: 100, height: length)
                        .opacity(0.9)
                        .foregroundColor(.red)
                    Spacer()
                }
            }
        }.frame(height: 400)
    }
}
