//
//  HomePageFileCell.swift
//  CodeViewerLite
//
//  Created by wanghong on 2017/2/9.
//  Copyright © 2017年 wanghong. All rights reserved.
//

import UIKit

class HomePageFileCell: UITableViewCell {

    var fileModel:FileModel?{
        didSet{
            self.textLabel?.text = fileModel?.fileName
            self.detailTextLabel?.text = String(describing: fileModel?.isDirectory) + " " + (fileModel?.fileType)!
            
            if (fileModel?.isDirectory)! {
                self.imageView?.image = #imageLiteral(resourceName: "folder")
            }else{
                self.imageView?.image = #imageLiteral(resourceName: "fileIcon")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
