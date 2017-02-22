//
//  HomePageViewController.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/1/21.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit

fileprivate let toBrowerSegueId = "toBrowerSegue"
fileprivate let cellID = "fileCell"

class HomePageViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var backButton: UIButton!
    
    var fileModels:[FileModel]?
    var currentFolderModel:FileModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        setData()
    }
    
    private func setData(){
        if currentFolderModel == nil {
            fileModels = FileHelper.getDocumentsFile()
            title = "Document"
        }else{
            fileModels = FileHelper.getFiles(withFolderModel: currentFolderModel!)
            title = currentFolderModel?.fileName
        }
    }
    
    private func setUI(){
        
        tableView.register(HomePageFileCell.self, forCellReuseIdentifier: cellID)
        
        let refreshControl = UIRefreshControl()
        refreshControl .addTarget(self, action: #selector(HomePageViewController.reloadData), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
            tableView.addSubview(refreshControl)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toBrowerSegueId{
            let toVC = segue.destination as? BrowerViewController
            toVC?.fileModel = sender as? FileModel
        }
    }
    
    func reloadData(sender : UIRefreshControl){
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setData()
            self.tableView.reloadData()
            sender.endRefreshing()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! HomePageFileCell
        
        let model = fileModels?[indexPath.row]
        cell.fileModel = model
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = fileModels?[indexPath.row]
        if (model?.isDirectory)! {
            let homePage = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homePage") as! HomePageViewController
            homePage.currentFolderModel = model
            self.show(homePage, sender: nil)
        }else{
            performSegue(withIdentifier: toBrowerSegueId, sender: model)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            
            let model = self.fileModels?[indexPath.row]
            FileHelper.deleteFile(withModel: model!)
            self.fileModels?.remove(at: indexPath.row)
            self.tableView .deleteRows(at: [indexPath], with: .left)
        }
        return [deleteAction]
    }
}
