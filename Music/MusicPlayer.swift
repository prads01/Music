
import SwiftUI

struct MusicPlayer: View {
    @Environment(\.colorScheme) var mode
    
    @Binding var fullScreen: Bool
    
    @Namespace var animate
    
    @State private var volume: CGFloat = 0.6
    @State private var offset: CGFloat = 0
    
    let music: MusicModel = musicList[2]
    let height = screen.height / 4
    
    func getDuration() -> String {
        let duration = music.duration/60
        let minute = Int(duration)
        let seconds = Int(60 * modf(duration).1)
        
        return "\(minute):\(seconds)"
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                if fullScreen {
                    Capsule()
                        .frame(width: 40, height: 5)
                        .opacity(0.6)
                }
                
                HStack(spacing: 20) {
                    Image("\(music.name) - \(music.artist)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: fullScreen ? screen.width * 0.82 : 50, height: fullScreen ? screen.width * 0.82 : 50)
                        .cornerRadius(fullScreen ? 10 : 4)
                        .shadow(radius: 10, y: 10)
                        .onTapGesture { if !fullScreen { withAnimation(.spring()) { fullScreen.toggle() } } }
                    
                    if !fullScreen {
                        Group {
                            Text(music.name)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .onTapGesture { if !fullScreen { withAnimation(.spring()) { fullScreen.toggle() } } }
                                .matchedGeometryEffect(id: music.name, in: animate)
                            
                            Spacer()
                            
                            Button(action: {
                                
                            }) {
                                Image(systemName: "play.fill")
                                    .foregroundColor(mode == .light ? .black : .white)
                            }
                            .transition(AnyTransition.offset(y: -50).combined(with: .opacity))
                            
                            Button(action: {
                                
                            }) {
                                Image(systemName: "forward.fill")
                                    .foregroundColor(mode == .light ? .black : .white)
                            }
                            .transition(AnyTransition.offset(y: -50).combined(with: .opacity))
                        }
                    }
                }
                .padding(.horizontal, 30)
                .zIndex(3)
                
                if fullScreen {
                    VStack(spacing: 40) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                if fullScreen {
                                    Text(music.name)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .matchedGeometryEffect(id: music.name, in: animate)
                                }

                                Text(music.artist)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            ZStack {
                                BlurView(style: .prominent)
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 18, weight: .heavy))
                            }
                        }
                        .padding(.horizontal, 25)

                        VStack(spacing: 4) {
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .frame(width: screen.width * 0.87, height: 5)
                                    .foregroundColor(Color(mode == .light ? .black : .white).opacity(0.2))

                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(Color(mode == .light ? .darkGray : .gray))
                            }

                            HStack {
                                Text("0:00")
                                Spacer()
                                Text(getDuration())
                            }
                            .font(.system(size: 14))
                            .foregroundColor(.secondary)
                            .frame(width: screen.width * 0.87)
                        }

                        HStack(spacing: 60) {
                            Button(action: {

                            }) {
                                Image(systemName: "backward.fill")
                                    .foregroundColor(mode == .light ? .black : .white)
                            }

                            Button(action: {

                            }) {
                                Image(systemName: "play.fill")
                                    .foregroundColor(mode == .light ? .black : .white)
                            }

                            Button(action: {

                            }) {
                                Image(systemName: "forward.fill")
                                    .foregroundColor(mode == .light ? .black : .white)
                            }
                        }
                        .font(.system(size: 40))

                        HStack(spacing: 20) {
                            Image(systemName: "speaker.fill")
                            
                            Slider(value: $volume)
                                .frame(width: screen.width * 0.65, height: 5)
                                .accentColor(Color(mode == .light ? .black : .white).opacity(0.6))

                            Image(systemName: "speaker.wave.3.fill")
                        }
                        .font(.caption)

                        HStack(spacing: 80) {
                            Image(systemName: "quote.bubble")

                            Image(systemName: "airplayaudio")

                            Image(systemName: "list.bullet")
                        }
                        .font(.system(size: 18, weight: .semibold))
                    }
                    .transition(AnyTransition.offset(y: 100).combined(with: .opacity))
                    .frame(width: fullScreen ? screen.width : nil)

                    Spacer()
                }
            }
            .padding(.top, fullScreen ? edge?.top : 0)
            .padding(.top, fullScreen ? 20 : 0)
            .zIndex(4)
        }
        .frame(maxWidth: screen.width, maxHeight: fullScreen ? screen.height : 70)
        .background(
            BlurView(style: .regular)
                .onTapGesture { if !fullScreen { withAnimation(.spring()) { fullScreen.toggle() } } }
                .cornerRadius(fullScreen ? 30 : 0)
        )
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchanged(value:)))
        .edgesIgnoringSafeArea(.all)
    }
    
    func onchanged(value: DragGesture.Value){
        
        // only allowing when its expanded...
        
        if value.translation.height > 0 && fullScreen {
            
            offset = value.translation.height
        }
    }
    
    func onended(value: DragGesture.Value){
        
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)){
            
            // if value is > than height / 3 then closing view...
            
            if value.translation.height > height {
                
                fullScreen = false
            }
            
            offset = 0
        }
    }
}

struct MusicPlayer_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayer(fullScreen: .constant(false))
    }
}
