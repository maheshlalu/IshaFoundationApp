//
//  YogaTableViewCell.swift
//  UniversalApp
//
//  Created by Mahesh Y on 08/06/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

import UIKit

class YogaTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.watchBtn.layer.cornerRadius = 8.0
        self.watchBtn.layer.borderColor = UIColor.blueColor().CGColor
        self.watchBtn.layer.borderWidth = 2.0
        // Initialization code
    }
    @IBOutlet weak var yogaIconImageView: UIImageView!

    @IBAction func watchButtonAction(sender: AnyObject) {
        
    }
    @IBOutlet weak var watchBtn: UIButton!
    @IBOutlet weak var yogaTitleLbl: UILabel!
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
