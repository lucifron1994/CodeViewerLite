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
            self.textLabel?.font = UIFont.systemFont(ofSize: 14)
            
            self.textLabel?.text = fileModel?.fileName
            
            if (fileModel?.isDirectory)! {
                self.imageView?.image = #imageLiteral(resourceName: "folder")
                return
            }
            
            if let icon = UIImage(named: "icon_" + fileModel!.fileType){
                self.imageView?.image = icon
            }else{
                self.imageView?.image = #imageLiteral(resourceName: "icon_default")
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
