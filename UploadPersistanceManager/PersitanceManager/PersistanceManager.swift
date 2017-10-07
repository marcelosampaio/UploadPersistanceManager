//
//  PersistanceManager.swift
//  UploadPersistanceManager
//
//  Created by Marcelo on 10/7/17.
//  Copyright © 2017 MAS. All rights reserved.
//

import Foundation

private let sharedInstance = PersistanceManager()
private let midiaFolder = "/Midias"
private let photosFolder = "/Photos"
private let videosFolder = "/Videos"
private let audiosFolder = "/Audios"
private let miscFolder = "/Misc"

class PersistanceManager {
    public var commonString = String()
    
    enum fileType {
        case Photo
        case Video
        case Audio
        case Misc
    }
    
    // MARK: - Instance
    class var standard: PersistanceManager {
        return sharedInstance
    }
    
    // MARK: - Instance Helpers
    public func createFolderStructure() {
        // ------------------
        // Documents Folder
        //      - Midias
        //          - Audios
        //          - Misc
        //          - Photos
        //          - Videos
        // ------------------

        let midiasPath = documentsFolder() + midiaFolder
        createFolderAtPath(midiasPath)
        var path = midiasPath + photosFolder
        createFolderAtPath(path)
        path = midiasPath + videosFolder
        createFolderAtPath(path)
        path = midiasPath + audiosFolder
        createFolderAtPath(path)
        path = midiasPath + miscFolder
        createFolderAtPath(path)

    }
    
    public func getApplicationFolder() -> String {
        return applicationFolder()
    }
    
    public func getDocumentsFolder() -> String {
        return documentsFolder()
    }
    
    // MARK: - Instance Methods
    public func addFile(data: Data, type: fileType) -> Bool {
        
        if data.isEmpty {
            print("👎 photo is empty ❌")
            return false
        }

        // path composer
        let path = pathComposer(type: type)
        
        // save file to the disk
        do {
            try data.write(to: URL(fileURLWithPath: path), options: .atomic)
        } catch {
            print("👎 error write file to the disk ❌")
            return false
        }
        
        
        
        print("👍 addFile has been called")
        return true
    }
    
//    private func addFile() {
//        let fileManager = FileManager.default
//        do {
//            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
//            let fileURL = documentDirectory.appendingPathComponent("fileName")
//            let image = #imageLiteral(resourceName: "Notifications")
//            if let imageData = UIImageJPEGRepresentation(image, 0.5) {
//                try imageData.write(to: fileURL)
//            }
//        } catch {
//            print(error)
//        }
//
//        print("🐛 ens")
//
//    }

    
    
    
    
    
    
    public func addFiles(_ photos: [Data]) -> Bool {
        return true
    }
    
    public func getFile(_ name: String) -> Data {
        return Data()
    }
    
    public func getFiles() -> [String] {
        return [String]()
    }
    
    public func deleteFile(_ name: String) -> Bool {
        return true
    }
    
    public func deleteFiles() -> Bool {
        return true
    }
    
    
    
    
    
    // MARK: - Private Helpers
    private func applicationFolder() -> String {
        return Bundle.main.resourcePath!
    }
    
    private func documentsFolder() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    private func createFolderAtPath(_ path: String) {
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }

    }
    
    private func pathComposer(type: fileType) -> String {
        
        var path = documentsFolder()
        if type == .Audio {
            path = path + audiosFolder
        } else if type == .Misc {
            path = path + miscFolder
        } else if type == .Photo {
            path = path + photosFolder
        } else {
            path = path + videosFolder
        }
        
        return path
    }
    
    
    
    
}


