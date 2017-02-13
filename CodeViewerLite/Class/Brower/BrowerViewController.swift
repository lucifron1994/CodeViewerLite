//
//  BrowerViewController.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/1/21.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit
import Highlightr
import SnapKit
import ActionSheetPicker_3_0

class BrowerViewController: BaseViewController {
    
    var fileModel:FileModel?
    
    private var codeTextView: UITextView?
    @IBOutlet weak var titleButton: UIButton!
    
    private var highlightr : Highlightr!
    private let textStorage = CodeAttributedString()
    
    private var themeName : String = ""
    private var languageName : String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        initText()
        
        print(fileModel ?? "FileModel == NULL")
    }
    
    func setUI(){
    }
    
    func initText(){
        languageName = SettingHelper.shareHelper.language!
        themeName = SettingHelper.shareHelper.theme!
        
        titleButton.setTitle(languageName, for: .normal)
        
        
        textStorage.language = languageName
        textStorage.highlightr.setTheme(to: themeName)
        
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: view.bounds.size)
        layoutManager.addTextContainer(textContainer)
        
        
        codeTextView = UITextView(frame: view.bounds, textContainer: textContainer)
        codeTextView?.isEditable = false
        
        codeTextView?.autocorrectionType = UITextAutocorrectionType.no
        codeTextView?.autocapitalizationType = UITextAutocapitalizationType.none
        codeTextView?.textColor = UIColor(white: 0.8, alpha: 1.0)
        codeTextView?.alwaysBounceVertical  = true
        view.insertSubview(codeTextView!, at: 0)
        
        codeTextView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        //
//        let code = try! String.init(contentsOfFile: Bundle.main.path(forResource: "sampleCode", ofType: "txt")!)
        let code = try! String.init(contentsOfFile: (fileModel?.filePath)!)
        
        codeTextView?.text = code
        
        highlightr = textStorage.highlightr

        updateColors()
    }

    func updateColors()
    {
        codeTextView?.backgroundColor = highlightr.theme.themeBackgroundColor
//        self.navigationBar_.barTintColor = highlightr.theme.themeBackgroundColor
//        self.navigationBar_.tintColor = invertColor(self.navigationBar_.barTintColor!)
//        
//        self.navigationBarBG.backgroundColor = highlightr.theme.themeBackgroundColor
        
//        languageName.textColor = navBar.tintColor
//        themeName.textColor = navBar.tintColor.withAlphaComponent(0.5)
//        toolBar.barTintColor = navBar.barTintColor
//        toolBar.tintColor = navBar.tintColor
    }
    
    func invertColor(_ color: UIColor) -> UIColor
    {
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: nil)
        return UIColor(red:1.0-r, green: 1.0-g, blue: 1.0-b, alpha: 1)
    }
    @IBAction func changeTheme(_ sender: Any) {
        let themes = highlightr.availableThemes()
        let indexOrNil = themes.index(of: themeName.lowercased())
        let index = (indexOrNil == nil) ? 0 : indexOrNil!
        
        ActionSheetStringPicker.show(withTitle: "Pick a Theme",
                                     rows: themes,
                                     initialSelection: index,
                                     doneBlock:
            { picker, index, value in
                let theme = value! as! String
                self.textStorage.highlightr.setTheme(to: theme)
                self.themeName = theme.capitalized
                SettingHelper.shareHelper.theme = theme
                self.updateColors()
        },
                                     cancel: nil,
                                     origin: self.navigationController?.navigationBar)
    }

    @IBAction func changeLanguage(_ sender: Any) {
        let languages = highlightr.supportedLanguages()
        let indexOrNil = languages.index(of: languageName.lowercased())
        let index = (indexOrNil == nil) ? 0 : indexOrNil!
        
        ActionSheetStringPicker.show(withTitle: "Pick a Language",
                                     rows: languages,
                                     initialSelection: index,
                                     doneBlock:
            { picker, index, value in
                let language = value! as! String
                self.textStorage.language = language
                self.languageName = language.capitalized
                self.titleButton.setTitle(language, for: .normal)
                SettingHelper.shareHelper.language = language
                
                let snippetPath = Bundle.main.path(forResource: "default", ofType: "txt", inDirectory: "CodeSamples/\(language)", forLocalization: nil)
                let snippet = try! String(contentsOfFile: snippetPath!)
                self.codeTextView?.text = snippet
                
        },
                                     cancel: nil,
                                     origin: self.navigationController?.navigationBar)
    }
 
    @IBAction func popController(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - StatusBar
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
