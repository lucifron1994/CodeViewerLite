//
//  FileHelper.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/1/21.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit

let kFirstTimeLaunchTagKey = "firstLaunchTagKey"

class FileHelper: NSObject {
    
    class func getDocumentsFile() -> [FileModel]{
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        print(documentPath ?? "Path Error")
        return getFiles(withPath: documentPath!)
    }
    
    class func getFiles(withFolderModel model:FileModel) -> [FileModel]{
        return getFiles(withPath: model.filePath)
    }
    
    class func deleteFile(withModel model : FileModel){
        let fileManager = FileManager.default
        do {
            try? fileManager.removeItem(atPath: model.filePath)
        }
    }
    
    // MARK - Private
    private class func getFiles(withPath path:String) -> [FileModel]{
        
        let fileManager = FileManager.default
        let filesPath = try! fileManager.contentsOfDirectory(atPath: path)
        print(filesPath)
        
        var fileModels = [FileModel]()
        
        for item in filesPath {
            if item == ".DS_Store" {
                continue
            }
            
            let filePath = path.appending("/"+item)
            
            var isDir : ObjCBool = false
            if fileManager.fileExists(atPath: filePath, isDirectory: &isDir){
                let encodeUrlStr = filePath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                let fileURL = URL(string: encodeUrlStr!)
                let fileType = (fileURL?.pathExtension != nil) ? fileURL?.pathExtension.lowercased() : ""
                
                let fileModel = FileModel(fileName: item, filePath:filePath , fileType:fileType! , isDirectory: isDir.boolValue)
                fileModels.append(fileModel)
            }
            
        }
        return fileModels
    }
    
    //MARK: - First Time Launch
    class func firstTimeLaunch(){
        
        let isFirstTimeTag = UserDefaults.standard.bool(forKey: kFirstTimeLaunchTagKey)
        if !isFirstTimeTag {
            // Add Help File into Documents Directory
            copyHelperFile()
            copyCodeDemo()
            
            UserDefaults.standard.set(true, forKey: kFirstTimeLaunchTagKey)
        }
    }
    
    
    class func copyHelperFile(){
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let toFilePath = documentPath?.appending("/Helper.txt");
        if !FileManager.default.fileExists(atPath: toFilePath!) {
            let fromFilePath = Bundle.main.path(forResource: "Helper", ofType: "txt")
            do {
                try? FileManager.default.copyItem(atPath: fromFilePath!, toPath: toFilePath!)
            }
        }

    }
    
    class func copyCodeDemo(){
        
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let toFilePath = documentPath?.appending("/SwiftDemo.swift");
        let fromFilePath = Bundle.main.path(forResource: "swift", ofType: "txt")

        
        if !FileManager.default.fileExists(atPath: toFilePath!) {
            let str = try! String(contentsOfFile: fromFilePath!)
            do {
               try? str.write(toFile: toFilePath!, atomically: true, encoding: .utf8)
            }
           
        }
        
    }
    
}
