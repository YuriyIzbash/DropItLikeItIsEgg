//
//  FileService.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import Foundation

struct FileService {
    let folderName: String

    private var directoryURL: URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let dir = urls[0].appendingPathComponent(folderName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: dir.path) {
            try? FileManager.default.createDirectory(at: dir, withIntermediateDirectories: true)
        }
        return dir
    }

    func save(_ data: Data, in fileName: String) throws {
        let url = directoryURL.appendingPathComponent(fileName)
        try data.write(to: url, options: .atomic)
    }

    func load(from fileName: String) throws -> Data {
        let url = directoryURL.appendingPathComponent(fileName)
        return try Data(contentsOf: url)
    }

    func delete(_ fileName: String) throws {
        let url = directoryURL.appendingPathComponent(fileName)
        if FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
    }
}
