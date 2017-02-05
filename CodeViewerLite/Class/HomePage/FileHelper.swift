//
//  FileHelper.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/1/21.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit

class FileHelper: NSObject {
    
    func getDocumentsFile(){
        _ = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        
    }
}
