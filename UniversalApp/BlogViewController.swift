//
//  BlogViewController.swift
//  UniversalApp
//
//  Created by Madhav Bhogapurapu on 04/06/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

import UIKit

class BlogViewController: UIViewController {

    @IBOutlet var blogWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let keepShoppingBtnColor : UIColor = UIColor(red: 16.0/255.0, green: 57.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        
        self.navigationController!.navigationBar.barTintColor = keepShoppingBtnColor
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let urlRequest : NSURLRequest = NSURLRequest(URL: NSURL(string: "https://www.innerengineering.com/online/blog/")!)
        self.blogWebView.loadRequest(urlRequest)
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
