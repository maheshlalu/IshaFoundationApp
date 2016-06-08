//
//  YogaViewController.swift
//  UniversalApp
//
//  Created by Madhav Bhogapurapu on 04/06/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

import UIKit

class YogaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var yogaTypeName : [String] = ["Nada Yoga","Yoga Namaskar","Nadi Shuddhi"]
    var yogaTypeImages : [String] = ["Nada-Yoga","Yoga-Namaskar","Nada-Shuddi"]

    var yogaVideos : [String] = ["lDZ7RP13B_8","WALEQp-o0QE","hqdwkIQy4RM"]
    var VideoID:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keepShoppingBtnColor : UIColor = UIColor(red: 16.0/255.0, green: 57.0/255.0, blue: 94.0/255.0, alpha: 1.0)

        self.navigationController!.navigationBar.barTintColor = keepShoppingBtnColor
        //self.navigationController?.navigationBarHidden  = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yogaTypeName.count
    }
  
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("YogaTableViewCell", forIndexPath: indexPath) as! YogaTableViewCell
        cell.yogaTitleLbl.text = self.yogaTypeName[indexPath.row]
        cell.watchBtn.tag = indexPath.row+1
        cell.yogaIconImageView.image = UIImage.init(named: yogaTypeImages[indexPath.row])
        cell.watchBtn.addTarget(self, action: #selector(YogaViewController.watchButtonTapped(_:)), forControlEvents: UIControlEvents.TouchUpInside)

            return cell
    }
    func watchButtonTapped(sender:UIButton){
        //        VideoID = videoIDArray.objectAtIndex(indexPath.row) as! String
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : PlayerViewController = mainStoryboard.instantiateViewControllerWithIdentifier("PlayerView") as! PlayerViewController
        VideoID = yogaVideos[sender.tag-1]
        vc.VideoID = VideoID
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
