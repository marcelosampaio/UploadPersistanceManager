//
//  MainSingleton.swift
//  UploadPersistanceManager
//
//  Created by Marcelo on 10/7/17.
//  Copyright © 2017 MAS. All rights reserved.
//

import Foundation
private let sharedSingleton = MainSingleton()

class MainSingleton {
    
    public var genericString = String()
    
    
    class var sharedInstance: MainSingleton {
        return sharedSingleton
    }
    
}
