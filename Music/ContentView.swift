
import SwiftUI

let screen = UIScreen.main.bounds
let edge = UIApplication.shared.windows.first?.safeAreaInsets

struct ContentView: View {
    @State private var index: Int = 2
    @State var fullScreen: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $index) {
                ListenNow()
                    .scaleEffect(fullScreen ? 0.9 : 1)
                    .cornerRadius(fullScreen ? 20 : 0)
                    .disabled(fullScreen)
                    .tag(1)
                    .tabItem {
                        Image(systemName: "play.circle.fill")
                        Text("Listen Now")
                    }
                
                Library(fullScreen: $fullScreen)
                    .tag(2)
                    .tabItem {
                        Image(systemName: "rectangle.stack.fill")
                        Text("Library")
                    }
                
                Search()
                    .scaleEffect(fullScreen ? 0.9 : 1)
                    .cornerRadius(fullScreen ? 20 : 0)
                    .disabled(fullScreen)
                    .tag(3)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
            }
            .accentColor(.pink)
            .zIndex(1)
            
            VStack(spacing: 0) {
                MusicPlayer(fullScreen: $fullScreen)
                
                Divider()
            }
            .offset(y: fullScreen ? 0 : -48)
            .zIndex(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
