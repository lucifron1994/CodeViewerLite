//
//  BaseViewController.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/2/9.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavi(){
        if (navigationController?.viewControllers.count)! > 1 {
            let backItem = UIBarButtonItem(image: UIImage.init(named: "nav_back"), style: .plain, target: self, action: #selector(self.popViewController))
            self.navigationItem.leftBarButtonItem = backItem
            backItem.imageInsets = UIEdgeInsetsMake(0, -15, 0, 15)
            
            navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    func popViewController(){
        _ = navigationController?.popViewController(animated: true)
    }
}
