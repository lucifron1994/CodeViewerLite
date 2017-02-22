//
//  SetttingHelper.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/2/9.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit

let kLanguageNameKey = "lastUseLanguageNameKey"
let kThemeNameKey = "lastUseThemeNameKey"
let kFontSizeIndexKey = "fontSizeKey"

final class SettingHelper: NSObject {
    static let shareHelper = SettingHelper()
    private override init(){}
    
    var theme:String?{

        get{
            if let themeName = UserDefaults.standard.object(forKey: kThemeNameKey) as? String{
                return themeName
            }else{
                return "xcode"
            }
        }
       
        set{
            UserDefaults.standard.setValue(newValue, forKey: kThemeNameKey)
        }
    }
    
    var language:String?{
        get{
            if let languageName = UserDefaults.standard.object(forKey: kLanguageNameKey) as? String{
                return languageName
            }else{
                return "swift"
            }
        }
        
        set{
            UserDefaults.standard.setValue(newValue, forKey: kLanguageNameKey)
        }
    }
    
    var fontSizeIndex:Int?{
        get{
            if UserDefaults.standard.object(forKey: kFontSizeIndexKey) != nil {
                let i = UserDefaults.standard.integer(forKey: kFontSizeIndexKey)
                return i
            }else{
                return 2
            }
            
        }
        
        set{
            UserDefaults.standard.set(newValue, forKey: kFontSizeIndexKey)
        }
    }
}
