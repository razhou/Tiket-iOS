//
//  NSObjectExt.swift
//  Tiket
//
//  Created by Jelajah Data Semesta on 22/04/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation
import UIKit

extension NSObject{
    
    //Name Of class
    class var stringRepresentation: String {
        let name = String(describing:self)
        return name
        
    }
    
}
