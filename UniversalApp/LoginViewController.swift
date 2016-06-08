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
    
       // loginWithFacebook.delegate = self
       // loginWithFacebook.readPermissions = ["public_profile", "email", "user_friends"];
        // Do any additional setup after loading the view.
    }

    @IBAction func loginWithFaceBook(sender: UIButton) {
        
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["public_profile", "email", "user_friends"], fromViewController: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions.contains("email"))
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

}
