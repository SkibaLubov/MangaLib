//
//  ContentView.swift
//  MangaReader
//
//  Created by Скиба Любовь on 08.12.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var mangaFile: MangaFileViewModel = MangaFileViewModel()

    var body: some View {
        ScrollView([.vertical]) {
            if let datas = mangaFile.mangaSource?.datas {
                ForEach(datas, id: \.self) { data in
                    createImage(data)
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        
        .toolbar {
            Button("Open") {
                let panel = NSOpenPanel()
                if (panel.runModal() == .OK) {
                    guard let url = panel.url else {
                        return
                    }
                    do {
                        try mangaFile.loadFile(with: url)
                    } catch {
                        print("\(error)")
                    }
                    
                }
            }
        }
    }
    
    func createImage(_ value: Data) -> Image {
    #if canImport(UIKit)
        let songArtwork: UIImage = UIImage(data: value) ?? UIImage()
        return Image(uiImage: songArtwork)
    #elseif canImport(AppKit)
        let songArtwork: NSImage = NSImage(data: value) ?? NSImage()
        return Image(nsImage: songArtwork)
    #else
        return Image(systemImage: "some_default")
    #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
