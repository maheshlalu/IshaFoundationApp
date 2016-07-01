//
//  LoginViewController.swift
//  UniversalApp
//
//  Created by Madhav Bhogapurapu on 04/06/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
class LoginViewController: UIViewController,FBSDKLoginButtonDelegate {

    @IBOutlet var parentView: UIView!
    @IBOutlet var backGroundBgView: UIImageView!
    @IBOutlet weak var loginWithFacebook: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.view.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "iphone_LMain")!)
       // loginWithFacebook.delegate = self
       // loginWithFacebook.readPermissions = ["public_profile", "email", "user_friends"];
        // Do any additional setup after loading the view.
    }

    @IBAction func cancelButtonAction(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
    
    /*
     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)//TabBarID
     
     let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("SignUpID") as! SignUpViewController
     self.navigationController?.pushViewController(nextViewController, animated: true)
     */
    @IBAction func loginWithFaceBook(sender: UIButton) {
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.loginBehavior = FBSDKLoginBehavior.Web
        fbLoginManager.logInWithReadPermissions(["public_profile", "email", "user_friends"], fromViewController: self) { (result, error) -> Void in
            if (error == nil){
                 if result.isCancelled {
                    print("Canceled")
                    return
                }
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                let value = fbloginresult.grantedPermissions.contains("email")
                if(value)
                {
                    self.getFBUserData()
                }
            }
        }
        
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    print(result)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)//TabBarID
                    
                    let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("TabBarID") as! UITabBarController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    Services.sharedInstance().postmethod(result.valueForKey("name") as? String, email: result.valueForKey("email") as? String)
                    /*
                     {
                     email = "yernagulamahesh@gmail.com";
                     "first_name" = Mahesh;
                     id = 953992734697907;
                     "last_name" = Yernagula;
                     name = "Mahesh Yernagula";
                     picture =     {
                     data =         {
                     "is_silhouette" = 0;
                     url = "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xpt1/v/t1.0-1/p200x200/12141625_831479470282568_6545670520184818024_n.jpg?oh=74d5340e4d1a7eb8c7db7898cd72914a&oe=57D539C4&__gda__=1472797113_147f6b673b7739e42c8f31b3e3c9f0b8";
                     };
                     };
                     }
                     */
                }
            })
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        // print("Response \(result)")
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large),id"]).startWithCompletionHandler { (connection, result, error) -> Void in
            //print ("FB Result is \(result)")
            
            let strFirstName: String = (result.objectForKey("first_name") as? String)!
            let strLastName: String = (result.objectForKey("last_name") as? String)!
            let userID: String = (result.objectForKey("id") as? String)!
            //let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            //print("Welcome, \(strFirstName) \(strLastName) \(userID)")
            
            NSUserDefaults.standardUserDefaults().setObject(userID, forKey: "USER_ID")
            NSUserDefaults.standardUserDefaults().setObject(strFirstName, forKey: "FIRST_NAME")
            NSUserDefaults.standardUserDefaults().setObject(strLastName, forKey: "LAST_NAME")
            NSUserDefaults.standardUserDefaults().synchronize()
            //self.showAlertView("Login successfully.", status: 1)
            //UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
        }
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.parentView.bringSubviewToFront(self.view)
    }
    
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        if (toInterfaceOrientation.isLandscape) {
            NSLog("Landscape");
            //self.view.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "iphone_LMain")!)

        }
        else {
            NSLog("Portrait");
            //self.view.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "iphone_PMain")!)

        }
    }

    @IBAction func loginButtonAction(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)//TabBarID
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("TabBarID") as! UITabBarController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
