//
//  TableViewCell.swift
//  DoubleTableViewDemo
//
//  Created by Developer on 15/6/30.
//  Copyright (c) 2015年 海涛旅游. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var third: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setWithData(row: Int){
        firstLabel.text = "\(row)1"
        secondLabel.text = "\(row)2"
        third.text = "\(row)3"
    }
    
}
