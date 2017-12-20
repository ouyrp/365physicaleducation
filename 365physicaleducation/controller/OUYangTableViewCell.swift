//
//  OUYangTableViewCell.swift
//  365physicaleducation
//
//  Created by ouyang on 2017/12/19.
//  Copyright © 2017年 ouyang. All rights reserved.
//

import UIKit
import SDWebImage

class OUYangTableViewCell: UITableViewCell {
    
    let labelTitle = UILabel()
    let newsImage = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(labelTitle);
        self.contentView.addSubview(newsImage)
        
        labelTitle.numberOfLines = 0
        
        
        newsImage.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.top.equalTo(8)
            make.width.height.equalTo(50)
            make.bottom.equalTo(self.contentView).offset(-8)
        }
        
        labelTitle.snp.makeConstraints { (make) in
            make.left.equalTo(newsImage.snp.right).offset(8)
            make.top.equalTo(8)
            make.right.equalTo(self.contentView).offset(-8)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(newData: TestEntity) {
        newsImage.sd_setImage(with: NSURL.init(string: newData.picUrl) as! URL, completed: nil)
        labelTitle.text = newData.title
    }
}
