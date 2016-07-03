//
//  YogaViewController.swift
//  UniversalApp
//
//  Created by Madhav Bhogapurapu on 04/06/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

import UIKit

class YogaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var yogaTypeName : [String] = ["Nada Yoga","Yoga Namaskar","Nadi Shuddhi","Yoga for Health","Yoga for Joy","Yoga for Love","Yoga for Peace","Yoga for Success","Yoga for Wellbeing"]
    var yogaTypeImages : [String] = ["Nada-Yoga","Yoga-Namaskar","Nada-Shuddi","Nada-Yoga","Yoga-Namaskar","Nada-Shuddi","Nada-Yoga","Yoga-Namaskar","Nada-Shuddi"]

    var yogaVideos : [String] = ["lDZ7RP13B_8","WALEQp-o0QE","hqdwkIQy4RM","BGVvLoyalm0","CCPLrqDiokU","Ks2bQCqNROg","dd7QelgqtRc","gmQnnZLZ4Rw","1I0w6jcmu5Y"]
    var VideoID:String!

    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var imageStackView: UIStackView!
    @IBOutlet weak var tableStackView: UIStackView!
    @IBOutlet var yogaTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keepShoppingBtnColor : UIColor = UIColor(red: 16.0/255.0, green: 57.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.barTintColor = keepShoppingBtnColor
        self.yogaTableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        self.view.backgroundColor = UIColor.clearColor()
        self.tabBarController?.delegate = self
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

extension YogaViewController : UITabBarControllerDelegate{
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if viewController.title == "Share" {
            //do your custom actions
            let actionSheetController: UIAlertController = UIAlertController(title: "", message: "", preferredStyle: .ActionSheet)
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            actionSheetController.addAction(cancelAction)
            //Create and add first option action
            let takePictureAction: UIAlertAction = UIAlertAction(title: "Share", style: .Default) { action -> Void in
                //Code for launching the camera goes here
                let textToShare = "ishaApp blog"
                
                if let myWebsite = NSURL(string: "https://www.innerengineering.com/online/blog/") {
                    let objectsToShare = [textToShare, myWebsite]
                    let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                    
                    //New Excluded Activities Code
                    activityVC.excludedActivityTypes = [UIActivityTypeAirDrop, UIActivityTypeAddToReadingList]
                    //
                    
                    activityVC.popoverPresentationController?.sourceView = self.view
                    self.presentViewController(activityVC, animated: true, completion: nil)
                }
            }
            actionSheetController.addAction(takePictureAction)
            //Create and add a second option action
            // let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) { action -> Void in
            //Code for picking from camera roll goes here
            
            actionSheetController.popoverPresentationController?.sourceView = self.view
            actionSheetController.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height-10, self.view.bounds.size.width, self.view.bounds.size.height)
            // this is the center of the screen currently but it can be any point in the view
            
            self.presentViewController(actionSheetController, animated: true, completion: nil)
            return false
        }
        //  actionSheetController.addAction(choosePictureAction)
        
        //Present the AlertController
        
        return true
    }
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController)
    {
        //tabBarController.selectedIndex = 1;
        
    }
    
}
