//
//  ViewController.swift
//  UploadPersistanceManager
//
//  Created by Marcelo on 10/6/17.
//  Copyright © 2017 MAS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    let imageBin = NSData()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()


        let persistanceManager = PersistanceManager.standard

        print("👉 Application Folder: \(persistanceManager.getApplicationFolder())")
        print("👉 Documents Folder: \(persistanceManager.getDocumentsFolder())")
        print("👉 Midias Folder: \(persistanceManager.getMidiasFolder())")
        print("👉 Audios Folder: \(persistanceManager.getAudiosFolder())")
        print("👉 Misc Folder: \(persistanceManager.getMiscFolder())")
        print("👉 Photos Folder: \(persistanceManager.getPhotosFolder())")
        print("👉 Videos Folder: \(persistanceManager.getVideosFolder())")
        
        // create file system structures
        persistanceManager.createFolderStructure()
        
        // ===========
        // ADD FILE
        // ===========
        let image = UIImage.init(named: "img1")
        let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
    
        // ----------------------------------------------------------------
        // Add a single file
//        _ = persistanceManager.addFile(data: imageData, type: .Photo)
        // ----------------------------------------------------------------
        
        
        
        
        // ===========
        // ADD FILES
        // ===========
        // ----------------------------------------------------------------
        // Add multiple files
//        var dataArray = [NSData]()
//        dataArray.append(imageData)
//        dataArray.append(imageData)
//        dataArray.append(imageData)
//        dataArray.append(imageData)
//        dataArray.append(imageData)
//        dataArray.append(imageData)
//        dataArray.append(imageData)
//
//        _ = persistanceManager.addFiles(dataArray: dataArray, type: .Photo)
        // ----------------------------------------------------------------
        
        
        // ===========
        // DELETE FILE
        // ===========
//        _ = persistanceManager.deleteFile("1", type: .Photo)
        
        
        
        // ============
        // DELETE FILES
        // ============
//        _ = persistanceManager.deleteFiles(type: .Photo)

        
        // ================
        // GET FILES NAMES
        // ================
        let files = persistanceManager.getFilesNames(.Photo)
        print("👉 files.count: \(files.count)")
        
        
        // ================
        // GET FILE
        // ================
//        let file = persistanceManager.getFileAttributes("10", type: .Photo)
//        print("👉 files: \(file)")
        
        
        
    }


}

