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
        
        // create sile system structures
        persistanceManager.createFolderStructure()
        
        let photo = Data()
        _ = persistanceManager.addFile(data: photo, type: .Photo)
        
        
    }


}

