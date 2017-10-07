//
//  PersistanceManager.swift
//  UploadPersistanceManager
//
//  Created by Marcelo on 10/7/17.
//  Copyright © 2017 MAS. All rights reserved.
//

import Foundation

private let sharedInstance = PersistanceManager()

class PersistanceManager {
    public var commonString = String()
    
    class var instance: PersistanceManager {
        return sharedInstance
    }
    
}


