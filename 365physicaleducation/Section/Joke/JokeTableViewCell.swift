//
//  JokeTableViewCell.swift
//  365physicaleducation
//
//  Created by sunny on 2017/12/20.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import UIKit
import Reusable

class JokeTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var createTimeLabel: UILabel!
    
    
    var joke: JokeEntity! {
        didSet {
            titleLabel.text = joke.title
            contentLabel.text = joke.text
            createTimeLabel.text = joke.createTime
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }


}
