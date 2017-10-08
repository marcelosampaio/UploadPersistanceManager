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
        
        let image = UIImage.init(named: "img1")
        let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
        
//        _ = persistanceManager.addFile(data: imageData, type: .Photo)
        
        var imageArray = [NSData]()
        imageArray.append(imageData)
        imageArray.append(imageData)
        imageArray.append(imageData)
        
        
        
//        _ = persistanceManager.addFile(data: imageData, type: .Photo)
        _ = persistanceManager.addFiles(imageArray, type: .Photo)
        
        
    }


}

