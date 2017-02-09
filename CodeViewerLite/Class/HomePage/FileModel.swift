//
//  FileModel.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/2/6.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit

class FileModel: NSObject {
    var fileName:String
    var filePath:String
    var fileType:String
    
    var isDirectory:Bool
    
    init(fileName:String, filePath:String, fileType:String, isDirectory:Bool) {
        self.fileName = fileName
        self.filePath = filePath
        self.fileType = fileType
        self.isDirectory = isDirectory
    }
}
