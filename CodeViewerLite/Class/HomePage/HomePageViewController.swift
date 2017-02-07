//
//  HomePageViewController.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/1/21.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit

fileprivate let toBrowerSegueId = "toBrowerSegue"

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var navigationBarBG: UIView!
    @IBOutlet weak var navigationBar_: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
//    var currentFile:FileModel?
    
    var fileModels:[FileModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        
        fileModels = FileHelper.getDocumentsFile()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toBrowerSegueId{
            let toVC = segue.destination as? BrowerViewController
            toVC?.fileModel = sender as? FileModel
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

extension HomePageViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.fileModels?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        let model = fileModels?[indexPath.row]
        cell?.textLabel?.text = model?.fileName
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = fileModels?[indexPath.row]
//        currentFile = model
        
        performSegue(withIdentifier: toBrowerSegueId, sender: model)
    }
}
