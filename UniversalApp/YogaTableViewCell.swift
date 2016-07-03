//
//  YogaTableViewCell.swift
//  UniversalApp
//
//  Created by Mahesh Y on 08/06/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

import UIKit

protocol AppDataDelegate {
    func watchButtonAction(sender: UIButton)
    
}
class YogaTableViewCell: UITableViewCell {
    var dataDelegate:AppDataDelegate?


    override func awakeFromNib() {
        super.awakeFromNib()

        self.watchBtn.layer.cornerRadius = 8.0
        self.watchBtn.layer.borderColor = UIColor(red: 16.0/255.0, green: 57.0/255.0, blue: 94.0/255.0, alpha: 1.0).CGColor
        self.watchBtn.layer.borderWidth = 2.0
        self.watchBtn.layer.masksToBounds = true
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
