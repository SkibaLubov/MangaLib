import Foundation
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

protocol MangaSource {
    var datas: [Data] { get }
}

class MangaFileViewModel: ObservableObject {
    @Published var mangaSource: Optional<MangaSource> = nil
    
    func loadFile(with url: URL) throws {
        mangaSource = try MangaFileDecoder.unpack(fileWithUrl: url)
    }
}

extension MangaDataSource: MangaSource {}
