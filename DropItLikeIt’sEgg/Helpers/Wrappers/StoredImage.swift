//
//  StoredImage.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import UIKit

@propertyWrapper
struct StoredImage: Codable, Hashable {
    private var image: UIImage? = nil
    private var fileName: String
    private var folderName: String
    private let separator: String = "_folder_"
    
    var wrappedValue: UIImage? {
        get { image }
        set {
            image = newValue
            if let newValue {
                saveImage(newValue)
            } else {
                try? deleteFromDisk()
            }
        }
    }
    
    var projectedValue: StoredImage { self }
    
    init(wrappedValue: UIImage? = nil, in folderName: String) {
        self.folderName = folderName
        self.fileName = "\(folderName)\(separator)\(UUID().uuidString).jpeg"
        self.image = wrappedValue
        if let wrapped = wrappedValue {
            saveImage(wrapped)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        fileName = try container.decode(String.self)
        
        let parts = fileName.split(separator: separator, maxSplits: 1, omittingEmptySubsequences: true)
        guard let folderPart = parts.first else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription:("Invalid filename format: \(fileName)"))
        }
        
        self.folderName = String(folderPart)
        if let data = try? fileService.load(from: fileName) {
            self.image = UIImage(data: data)
        } else {
            self.image = nil
        }
    }
    
    private var fileService: FileService {
        FileService(folderName: folderName)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(fileName)
    }
    
    func deleteFromDisk() throws {
        try fileService.delete(fileName)
    }
    
    private func saveImage(_ imageToSave: UIImage) {
        guard let data = imageToSave.jpegData(compressionQuality: 0.7) else { return }
        try? fileService.save(data, in: fileName)
    }
}

extension StoredImage: Equatable {
    static func == (lhs: StoredImage, rhs: StoredImage) -> Bool {
        lhs.fileName == rhs.fileName
    }
}
