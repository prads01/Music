
import SwiftUI

struct MusicModel: Identifiable {
    var id = UUID()
    var name: String
    var artist: String
    var duration: TimeInterval
}
