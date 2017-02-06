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
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let fileManager = FileManager.default
        let filesPath = try! fileManager.contentsOfDirectory(atPath: documentPath!)
        print(filesPath)
        
    }
}
