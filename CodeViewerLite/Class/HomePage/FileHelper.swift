//
//  FileHelper.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/1/21.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit

class FileHelper: NSObject {
    
    class func getDocumentsFile() -> [FileModel]{
        
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        print(documentPath ?? "Path Error")
        
        let fileManager = FileManager.default
        let filesPath = try! fileManager.contentsOfDirectory(atPath: documentPath!)
        print(filesPath)
        
        var fileModels = [FileModel]()
        
        for item in filesPath {
            let fileModel = FileModel()
            fileModel.fileName = item
            fileModel.filePath = documentPath?.appending("/"+item)
//            print("Model : " + fileModel.fileName! + fileModel.filePath!);
            fileModels.append(fileModel)
        }
        return fileModels
    }
    
}
