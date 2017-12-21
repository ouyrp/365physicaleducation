//
//  CartoonTableViewCell.swift
//  365physicaleducation
//
//  Created by sunny on 2017/12/21.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

class CartoonTableViewCell: UITableViewCell, NibReusable {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    
    var cartoon: CartoonEntity! {
        didSet {
            titleLabel.text = cartoon.title

            if cartoon.thumbnailList.count == 3 {
                imageView3.kf.setImage(with: URL(string: cartoon.thumbnailList[2])!)
            } else if  cartoon.thumbnailList.count == 2 {
                imageView2.kf.setImage(with: URL(string: cartoon.thumbnailList[1])!)
            } else if  cartoon.thumbnailList.count == 1 {
                imageView1.kf.setImage(with: URL(string: cartoon.thumbnailList[0])!)
            }
        }
    }

    
}
