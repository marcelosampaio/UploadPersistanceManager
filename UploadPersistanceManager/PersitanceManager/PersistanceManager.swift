//
//  PersistanceManager.swift
//  PersistanceManager
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

private let sequenceNumberKey = "PersistanceManagerSequenceNUmber"

class PersistanceManager {

    
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
    
    public func getMidiasFolder() -> String {
        return documentsFolder() + midiaFolder
    }

    public func getAudiosFolder() -> String {
        return documentsFolder() + midiaFolder + audiosFolder
    }
    
    public func getMiscFolder() -> String {
        return documentsFolder() + midiaFolder + miscFolder
    }
    
    public func getPhotosFolder() -> String {
        return documentsFolder() + midiaFolder + photosFolder
    }
    
    public func getVideosFolder() -> String {
        return documentsFolder() + midiaFolder + videosFolder
    }
    
    // MARK: - Instance Methods
    
    public func fileExists(name: String, type: fileType) -> Bool {
        // path composer
        let path = pathComposer(type: type)
        let pathFileName = path + "/" + name
        
        // file system
        let fileManager = FileManager.default
        
        // Check if file exists, given its path
        
        if fileManager.fileExists(atPath: pathFileName) {
            return true
        }
        return false
    }
    
    public func addFile(data: NSData, type: fileType) -> (absolutePath: String, error: NSError) {
        
        // path composer
        let path = pathComposer(type: type)
        let sequenceNumber = getSequenceNumber()
        let fileName = "/" + String(sequenceNumber) + fileExtension(type: type)
        let pathFileName = path + fileName
        
        // save file to the disk
        do {
            try data.write(toFile: pathFileName, options: .atomic)
            
            // update sequence number
            setSequenceNumber(sequenceNumber)
            return(pathFileName,NSError())
            
        } catch {
            print("👎 error write file: \(path) ❌ error: \(error)")
            let errorDomain = NSLocalizedString("app-domain-name", comment:"")
            let errorCode = 8000
            let errorUserInfo = [NSLocalizedDescriptionKey : NSLocalizedString("error-addFile", comment:"")]
            let errorObject = NSError.init(domain: errorDomain, code: errorCode, userInfo: errorUserInfo)
            
            return (String(),errorObject)
            
        }
    }
    
    public func addFiles(files: [NSData], type: fileType) -> [(absolutePath: String, error: NSError)] {
        var resultTuples: [(absolutePath: String, error: NSError)]  = []
        
        for file in files {
            let result = addFile(data: file, type: type)
            resultTuples.append(result)
        }
        
        return resultTuples
    }
    
    public func getFile(name: String,type: fileType) -> NSData{
        // path composer
        let path = pathComposer(type: type)
        let pathFileName = path + "/" + name
        
        return NSData()
    }
    
    
    public func getFileAttributes(_ name: String, type: fileType) -> NSDictionary {
        
        // path composer
        let path = pathComposer(type: type)
        let pathFileName = path + "/" + name
        
        // File System
        let fileManager = FileManager.default
        do {
            let attributes = try fileManager.attributesOfItem(atPath: pathFileName)
            return attributes as NSDictionary
        }
        catch let error as NSError {
            print("👎 error getFileAttributes: \(error) ❌")
        }
        return NSDictionary()
    }
    
    public func getFilesNames(_ type: fileType) -> [String] {
        
        // path composer
        let path = pathComposer(type: type)
        
        let fileManager = FileManager.default
        
        do {
            let files = try fileManager.contentsOfDirectory(atPath: path)
            return files
        } catch {
            print("👎 error deletinf files at: \(path) ❌ error: \(error)")
    
        }
        return [String]()
    }
    
    public func deleteFile(_ name: String, type: fileType) -> Bool {
        
        let fileManager = FileManager.default
        
        // path composer
        let path = pathComposer(type: type)
        let pathFileName = path + "/" + name
        
        // save file to the disk
        do {
            try fileManager.removeItem(atPath: pathFileName)
        } catch {
            print("👎 error delete file: \(path) ❌ error: \(error)")
            return false
        }

        print("👍 addFile has been called and will return true")
        return true
        
    }
    
    public func deleteFiles(type: fileType) -> Bool {
        
        // path composer
        let path = pathComposer(type: type)

        let fileManager = FileManager.default
        
        do {
            let files = try fileManager.contentsOfDirectory(atPath: path)
            
            for file in files {
                print(" 🥑 Found \(file)")
                _ = deleteFile(file, type: .Photo)
            }
        } catch {
            print("👎 error deletinf files at: \(path) ❌ error: \(error)")
            return false
        }
        
        print("👍 delete files OK for type: \(type)")
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
        
        var path = documentsFolder() + midiaFolder
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
    
    private func fileExtension(type: fileType) -> String {
        var ext = ""
        if type == .Audio {
            ext = ""
        } else if type == .Misc {
            ext = ""
        } else if type == .Photo {
            ext = ""
        }else if type == .Video {
            ext = ""
        }else {
            ext = ""
        }
        return ext
    }
    
    
    
    // MARK: - Private Sequence Control
    private func getSequenceNumber() -> Int {
        let userDefaults = UserDefaults.standard
        let sequenceNumber = userDefaults.integer(forKey: sequenceNumberKey)
        return sequenceNumber + 1
    }
    
    private func setSequenceNumber(_ sequenceNumber: Int) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(sequenceNumber, forKey: sequenceNumberKey)
        userDefaults.synchronize()
    }
    
    
}


