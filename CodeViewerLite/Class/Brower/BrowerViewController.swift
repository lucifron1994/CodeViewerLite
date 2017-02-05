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

class BrowerViewController: UIViewController {

    var codeTextView: UITextView?
    
    var highlightr : Highlightr!
    let textStorage = CodeAttributedString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
      initText()

    }
    
    func initText(){
        textStorage.language = "swift"
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: view.bounds.size)
        layoutManager.addTextContainer(textContainer)
        
        
        codeTextView = UITextView(frame: view.bounds, textContainer: textContainer)
        
        codeTextView?.autocorrectionType = UITextAutocorrectionType.no
        codeTextView?.autocapitalizationType = UITextAutocapitalizationType.none
        codeTextView?.textColor = UIColor(white: 0.8, alpha: 1.0)
        view.addSubview(codeTextView!)
        
        codeTextView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        
        //
        let code = try! String.init(contentsOfFile: Bundle.main.path(forResource: "sampleCode", ofType: "txt")!)
        
        codeTextView?.text = code
        
        highlightr = textStorage.highlightr
        
        updateColors()
    }


    func updateColors()
    {
        codeTextView?.backgroundColor = highlightr.theme.themeBackgroundColor
//        navBar.barTintColor = highlightr.theme.themeBackgroundColor
//        navBar.tintColor = invertColor(navBar.barTintColor!)
//        languageName.textColor = navBar.tintColor
//        themeName.textColor = navBar.tintColor.withAlphaComponent(0.5)
//        toolBar.barTintColor = navBar.barTintColor
//        toolBar.tintColor = navBar.tintColor
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
