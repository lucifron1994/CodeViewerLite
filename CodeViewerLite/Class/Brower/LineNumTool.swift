//
//  LineNumTool.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/3/10.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit

fileprivate let cellID = "lineNumCell"

class LineNumTool: NSObject, UITableViewDataSource, UITableViewDelegate {

}

extension LineNumTool{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! LineNumCell
        cell.numLabel.text = "\(indexPath.row+1)"
        cell.backgroundColor = tableView.backgroundColor
        cell.selectionStyle = .none
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    
}
