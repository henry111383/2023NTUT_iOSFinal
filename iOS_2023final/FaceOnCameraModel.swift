import Foundation
import AVFoundation
import SwiftUI
import Vision

class FaceOnCameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCaptureVideoDataOutput()
    @Published var cameraQueue = DispatchQueue.init(label: "cameraQueue")
    @Published var preview : AVCaptureVideoPreviewLayer!
    @Published var picData = Data(count: 0)
    @Published var FaceHeight: CGFloat = 0.5
    @Published var FaceX: CGFloat = 0.5
    
    init(FaceHeight: CGFloat) {
        self.FaceHeight = FaceHeight
    }
    
    func Check(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status{
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    
    func setUp(){
        do{
            self.session.beginConfiguration()
            // 前置鏡頭
            let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            // 輸入
            let input = try AVCaptureDeviceInput(device: device!)
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }
            // 設置代理
            self.output.setSampleBufferDelegate(self, queue: cameraQueue)
            // 輸出
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            
            self.session.commitConfiguration()
            
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        DispatchQueue.main.async {
                do {
                    // ===  to ciImage   ===
                    let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
                    let ciimage = CIImage(cvPixelBuffer: imageBuffer)
                    // =====================
                    
                    // === FaceDetection ===
                    let requestHandler = VNImageRequestHandler(ciImage: ciimage, options: [:])
                    let faceDetectionRequest = VNDetectFaceRectanglesRequest()
                    try requestHandler.perform([faceDetectionRequest])
                    // =====================
                    guard let results = faceDetectionRequest.results else {
                        print("No detected Face")
                        return
                    }
                    for observation in results {
                        self.FaceHeight = (observation.boundingBox.midX)
//                        print(UIScreen.main.bounds.height*self.FaceHeight)
                        
                    }
                } catch {
                    print("Face detection failed: \(error)")
                }
            }
        }

}

