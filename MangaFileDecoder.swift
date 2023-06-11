
import Foundation
import AppKit
import ZIPFoundation

struct MangaDataSource {
    let datas: [Data]
}

enum MangaFileDecoder {
    
    enum Errors: Error {
        case cantOpenArchive
    }
    
    static var tmpDirectory = FileManager.default.temporaryDirectory
    
    // TODO: Fix this shit
    static func unpack(fileWithUrl url: URL) throws -> MangaDataSource {
        guard let archive = Archive(url: url, accessMode: .read) else  {
            throw Errors.cantOpenArchive
        }
        
        for file in archive {
            if file.type != .file {
                continue
            }
            _ = try archive.extract(file, consumer: { data in
                let url = tmpDirectory.appendingPathComponent(String(file.path.split(separator: "/").last!))
                if ((try? url.checkResourceIsReachable()) ?? false) {
                    return
                }
                _ = try archive.extract(file, to: url)
            })
        }
        
        var datas = [Data]()
        for imageURL in try FileManager.default.contentsOfDirectory(at: tmpDirectory, includingPropertiesForKeys: nil).sorted(by: {
            let left = Int($0.lastPathComponent.split(separator: ".").first!)
            let right = Int($1.lastPathComponent.split(separator: ".").first!)
            return left ?? 0 < right ?? 0
        }) {
            if imageURL.isDirectory {
                continue
            }
            datas.append(try Data(contentsOf: imageURL))
        }
        
        return MangaDataSource(datas: datas)
    }
}


