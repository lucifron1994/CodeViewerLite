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
        return getFiles(withPath: documentPath!)
    }
    
    class func getFiles(withFolderModel model:FileModel) -> [FileModel]{
        return getFiles(withPath: model.filePath!)
    }
    
    private class func getFiles(withPath path:String) -> [FileModel]{
        
        let fileManager = FileManager.default
        let filesPath = try! fileManager.contentsOfDirectory(atPath: path)
        print(filesPath)
        
        var fileModels = [FileModel]()
        
        for item in filesPath {
            if item == ".DS_Store" {
                continue
            }
            
            let fileModel = FileModel()
            fileModel.fileName = item
            fileModel.filePath = path.appending("/"+item)
            //            print("Model : " + fileModel.fileName! + fileModel.filePath!);
            var isDir : ObjCBool = false
            if fileManager.fileExists(atPath: fileModel.filePath!, isDirectory: &isDir){
                fileModel.isDirectory = isDir.boolValue
                fileModels.append(fileModel)
            }
            
        }
        return fileModels
    }
    
    
}
