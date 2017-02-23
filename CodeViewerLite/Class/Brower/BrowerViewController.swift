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
import SafariServices

class BrowerViewController: BaseViewController, UITextViewDelegate {
    
    var fileModel:FileModel?
    
    private var codeTextView: UITextView?
    
    @IBOutlet weak var languageButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var sizeStepper: UIStepper!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private var highlightr : Highlightr!
    private let textStorage = CodeAttributedString()
    
    private var themeName : String = ""
    private var languageName : String = ""
    private let fontSize = [10,12,14,16,18]
    
    private var fileCode : String = ""
    
    private let supportLanguages = ["bash","cpp","django","erlang","haskell","go","lua", "java", "javascript","json", "objectivec","php","python","ruby","smalltalk","sql","swift","xml"]
    
    private let supportThemes = ["agate", "androidstudio", "arduino-light", "arta", "atom-one-dark", "atom-one-light", "brown-paper", "dark", "darkula", "docco", "dracula", "far", "github-gist", "github", "googlecode", "grayscale", "gruvbox-dark", "gruvbox-light", "magula", "mono-blue", "monokai-sublime", "monokai", "ocean", "purebasic", "solarized-dark", "solarized-light", "sunburst", "vs", "xcode", "xt256", "zenburn"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        
        initText()
//        print(fileModel ?? "FileModel == NULL")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        self.codeTextView?.scrollRectToVisible(rect, animated: false)
        
        UIView.animate(withDuration: 0.3) {
            self.indicator.stopAnimating()
            self.codeTextView?.alpha = 1
        }
    }
    
    func setUI(){
        title = fileModel?.fileName
        
//        self.edgesForExtendedLayout = .all
//        self.extendedLayoutIncludesOpaqueBars = true
//        self.automaticallyAdjustsScrollViewInsets = true
        
        let pinchGes = UIPinchGestureRecognizer(target: self, action: #selector(BrowerViewController.pinchGesture(sender:)))
        view.addGestureRecognizer(pinchGes)
    }
    
    func initText(){
        languageName = SettingHelper.shareHelper.language!
        themeName = SettingHelper.shareHelper.theme!
        
        languageButton.title = languageName

        
        textStorage.language = languageName
        textStorage.highlightr.setTheme(to: themeName)
        
        //初始字号
        let fontIndex = SettingHelper.shareHelper.fontSizeIndex!
//        textStorage.highlightr.theme.codeFont = RPFont(name: "Courier", size: CGFloat(fontSize[fontIndex]))
        sizeStepper.value = Double(fontIndex)
        
        
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: view.bounds.size)
        layoutManager.addTextContainer(textContainer)
        
        
        codeTextView = UITextView(frame: view.bounds, textContainer: textContainer)
        codeTextView?.alpha = 0
        codeTextView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]

        codeTextView?.isEditable = false
        codeTextView?.delegate = self
        
        codeTextView?.dataDetectorTypes = .link
        codeTextView?.autocorrectionType = UITextAutocorrectionType.no
        codeTextView?.autocapitalizationType = UITextAutocapitalizationType.none
        codeTextView?.textColor = UIColor(white: 0.8, alpha: 1.0)
        codeTextView?.alwaysBounceVertical  = true
        view.insertSubview(codeTextView!, at: 0)
//        codeTextView?.contentOffset = CGPoint(x: 0, y: -64)
        
        codeTextView?.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom).offset(-44)
        })
        
        //
        fileCode = try! String.init(contentsOfFile: (fileModel?.filePath)!)
    
        codeTextView?.text = fileCode
        
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
        //        let themes = highlightr.availableThemes()
        
        let indexOrNil = supportThemes.index(of: themeName.lowercased())
        let index = (indexOrNil == nil) ? 0 : indexOrNil!
        
        ActionSheetStringPicker.show(withTitle: "Pick a Theme",
                                     rows: supportThemes,
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
        //        let languages = highlightr.supportedLanguages()
        let indexOrNil = supportLanguages.index(of: languageName.lowercased())
        let index = (indexOrNil == nil) ? 0 : indexOrNil!
        
        ActionSheetStringPicker.show(withTitle: "Pick a Language",
                                     rows: supportLanguages,
                                     initialSelection: index,
                                     doneBlock:
            { picker, index, value in
                let language = value! as! String
                self.textStorage.language = language
                self.languageName = language.capitalized
                
                self.languageButton.title = self.languageName
                
                SettingHelper.shareHelper.language = language
                do {
                    let snippet = try? String(contentsOfFile: (self.fileModel?.filePath)!)
                    self.codeTextView?.text = snippet
                }
                
        },
                                     cancel: nil,
                                     origin: self.navigationController?.navigationBar)
    }
    
    
    func pinchGesture(sender:UIPinchGestureRecognizer){
        if sender.state == .ended {
            
            if sender.scale > 1 {
                increaseFontSize()
            }else if sender.scale < 1{
                reduceFontSize()
            }
        }
    }
    
    @IBAction func changeFontSize(_ sender: UIStepper) {
        let size = fontSize[Int(sender.value)]
        self.textStorage.highlightr.theme.codeFont = RPFont(name: "Courier", size: CGFloat(size))
        codeTextView?.text = fileCode
        
        SettingHelper.shareHelper.fontSizeIndex = Int(sender.value)
    }
    
    func increaseFontSize() {
        var currentValue = sizeStepper.value
        print("Current \(currentValue) Max \(sizeStepper.maximumValue)")
        if currentValue < sizeStepper.maximumValue {
            currentValue = currentValue + 1
            sizeStepper.value = currentValue
            changeFontSize(sizeStepper)
        }
    }
    
    func reduceFontSize(){
        var currentValue = sizeStepper.value
        print("Current \(currentValue) Min \(sizeStepper.minimumValue)")
        if currentValue > sizeStepper.minimumValue {
            currentValue = currentValue - 1
            sizeStepper.value = currentValue
            changeFontSize(sizeStepper)
        }
    }
    
    // MARK: - StatusBar
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

extension BrowerViewController {
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        let offset = scrollView.contentOffset.y
    //        print(offset)
    //
    //        if offset>64 {
    //            bottomToolBar.isHidden = true
    //        }else{
    //            bottomToolBar.isHidden = false
    //        }
    //    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        print("Open URL \(URL)")
        if #available(iOS 9.0, *) {
            let safari = SFSafariViewController(url: URL, entersReaderIfAvailable: true)
            present(safari, animated: true, completion: nil)
            return false
        } else {
            // Fallback on earlier versions
            return true
        }
    }
}
