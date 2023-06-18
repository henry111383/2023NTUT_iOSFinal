
import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View{
        LogInView().ignoresSafeArea()
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
