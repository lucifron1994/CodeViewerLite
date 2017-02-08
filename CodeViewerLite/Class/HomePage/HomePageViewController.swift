//
//  HomePageViewController.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/1/21.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit

fileprivate let toBrowerSegueId = "toBrowerSegue"

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var navigationBarBG: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var fileModels:[FileModel]?
    var currentFolderModel:FileModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        if currentFolderModel == nil {
            fileModels = FileHelper.getDocumentsFile()
            titleButton.setTitle("", for: .normal)
        }else{
            fileModels = FileHelper.getFiles(withFolderModel: currentFolderModel!)
            titleButton.setTitle(currentFolderModel?.fileName, for: .normal)
        }
    }
    
    private func setUI(){
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
//        tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0)
        //        tableView.tableFooterView = UIView()
        
        if self.navigationController?.childViewControllers.count == 1 {
            backButton.isHidden = true
        }else{
            backButton.isHidden = false
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toBrowerSegueId{
            let toVC = segue.destination as? BrowerViewController
            toVC?.fileModel = sender as? FileModel
        }
    }
    
    @IBAction func popVC(_ sender: Any) {
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

extension HomePageViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.fileModels?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        let model = fileModels?[indexPath.row]
        cell?.textLabel?.text = model?.fileName
        cell?.detailTextLabel?.text = String(describing: model?.isDirectory)
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = fileModels?[indexPath.row]
        if (model?.isDirectory)! {
            let homePage = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homePage") as! HomePageViewController
            homePage.currentFolderModel = model
            self.show(homePage, sender: nil)
        }else{
            performSegue(withIdentifier: toBrowerSegueId, sender: model)
        }
    }
}
