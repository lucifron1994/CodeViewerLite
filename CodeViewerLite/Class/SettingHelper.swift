//
//  SetttingHelper.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/2/9.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit

let firstTagKey = "firstTagKey"
let languageNameKey = "lastUseLanguageNameKey"
let themeNameKey = "lastUseThemeNameKey"

final class SettingHelper: NSObject {
    static let shareHelper = SettingHelper()
    private override init(){}
    
    var theme:String?{

        get{
            if let themeName = UserDefaults.standard.object(forKey: themeNameKey) as? String{
                return themeName
            }else{
                return "Pojoaque"
            }
        }
       
        set{
            UserDefaults.standard.setValue(newValue, forKey: themeNameKey)
        }
    }
    
    var language:String?{
        get{
            if let languageName = UserDefaults.standard.object(forKey: languageNameKey) as? String{
                return languageName
            }else{
                return "swift"
            }
        }
        
        set{
            UserDefaults.standard.setValue(newValue, forKey: languageNameKey)
        }
    }
}
