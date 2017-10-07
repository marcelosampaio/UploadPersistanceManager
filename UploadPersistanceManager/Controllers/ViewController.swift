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
        // Do any additional setup after loading the view, typically from a nib.
        
        
        PersistanceManager.standard.commonString = ""
        
        
        
        
        
    }

    // MARK: - Manager Helpers
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


}

