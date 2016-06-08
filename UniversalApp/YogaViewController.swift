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
    var yogaVideos : [String] = ["https://www.youtube.com/watch?v=lDZ7RP13B_8"," https://www.youtube.com/watch?v=WALEQp-o0QE","https://www.youtube.com/watch?v=hqdwkIQy4RM"]

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier(
                "YogaTableViewCell", forIndexPath: indexPath)
                as! YogaTableViewCell
        cell.yogaTitleLbl.text = self.yogaTypeName[indexPath.row]
                return cell
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
