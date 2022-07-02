
import SwiftUI

struct Library: View {
    @Binding var fullScreen: Bool
    
    let libraryList: [String] = ["Playlists", "Artists", "Songs"]
    let libraryListImage: [String : String] = ["Playlists" : "music.note.list", "Artists" : "music.mic", "Songs" : "music.note"]
    let column = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ZStack {
            BlurView(style: .systemThickMaterial)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            NavigationView {
                ScrollView() {
                    VStack(spacing: 30) {
                        VStack(spacing: 0) {
                            Rectangle()
                                .foregroundColor(Color.gray.opacity(0.5))
                                .frame(width: screen.width - 35, height: 0.5)
                            
                            ForEach(libraryList, id: \.self) { item in
                                cell(item: item)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Recently Added")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .padding(.horizontal, 25)
                            
                            LazyVGrid(columns: column, spacing: 20) {
                                ForEach(musicList) { music in
                                    AlbumCell(music: music)
                                        .contextMenu(ContextMenu(menuItems: {
                                            Button(action: {
                                                // change country setting
                                            }) {
                                                Text("Love")
                                                Image(systemName: "heart")
                                            }
                                            
                                            Button(action: {
                                                // enable geolocation
                                            }) {
                                                Text("Play")
                                                Image(systemName: "play")
                                            }
                                            
                                            Button(action: {
                                                // enable geolocation
                                            }) {
                                                Text("Download")
                                                Image(systemName: "icloud.and.arrow.down")
                                            }
                                            
                                            Button(action: {
                                                // enable geolocation
                                            }) {
                                                Text("Delete")
                                                Image(systemName: "trash")
                                            }
                                        }))
                                }
                            }
                            .padding(.horizontal, 25)
                        }
                    }
                    .navigationTitle("Library")
                    .navigationBarItems(trailing: Text("Edit").foregroundColor(.pink))
                    
                    Spacer()
                        .frame(height: 80)
                }
            }
            .scaleEffect(fullScreen ? 0.9 : 1)
            .background(
                RoundedRectangle(cornerRadius: fullScreen ? 15 : 0)
                    .foregroundColor(Color(.black))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .scaleEffect(fullScreen ? 0.9 : 1)
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct cell: View {
    let item: String
    let libraryListImage: [String : String] = ["Playlists" : "music.note.list", "Artists" : "music.mic", "Songs" : "music.note"]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: libraryListImage[item]!)
                    .foregroundColor(.pink)
                    .frame(width: 40)
                
                Text(item)
                    .padding(.leading, 10)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.trailing, 10)
                    .foregroundColor(.secondary)
            }
            .font(.title2)
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.5))
                .frame(width: screen.width - 35, height: 0.5)
        }
    }
}

struct AlbumCell: View {
    let music: MusicModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Image("\(music.name) - \(music.artist)")
                .resizable()
                .frame(width: (screen.width/2) * 0.82, height: (screen.width/2) * 0.82)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(4)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(music.name)
                    .font(.system(size: 14))
                
                Text(music.artist)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library(fullScreen: .constant(false))
    }
}
