//
//  Extentions.swift
//  MangaReader
//
//  Created by Эдгар Назыров on 22.01.2023.
//

import Foundation

extension URL {
    var isDirectory: Bool {
       (try? resourceValues(forKeys: [.isDirectoryKey]))?.isDirectory == true
    }
}
