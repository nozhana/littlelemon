//
//  FileUtil.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/15/24.
//

import UIKit

struct FileUtil {
    fileprivate init() {}
    
    func write(_ image: UIImage, name: String) {
        guard let pngData = image.pngData() else { return }
        let fileName = name.hasSuffix("png") ? name : "\(name).png"
        let url = URL.documentsDirectory.appending(path: fileName)
        do {
            try pngData.write(to: url, options: [.atomic, .completeFileProtection])
        } catch {
            print("FileUtil: \(error.localizedDescription)")
        }
    }
    
    func read(image imageName: String) -> UIImage? {
        let fileName = imageName.hasSuffix("png") ? imageName : "\(imageName).png"
        let url = URL.documentsDirectory.appending(path: fileName)
        guard let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else { return nil }
        return image
    }
    
    @discardableResult
    func delete(image imageName: String) -> UIImage? {
        let fileName = imageName.hasSuffix("png") ? imageName : "\(imageName).png"
        let url = URL.documentsDirectory.appending(path: fileName)
        guard let data = try? Data(contentsOf: url),
              let uiImage = UIImage(data: data) else { return nil }
        try? FileManager.default.removeItem(at: url)
        return uiImage
    }
}

extension Container {
    var fileUtil: Factory<FileUtil> {
        self { .init() }
    }
}
