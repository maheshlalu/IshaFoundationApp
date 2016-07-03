//
//  SignUpViewController.swift
//  UniversalApp
//
//  Created by Rama kuppa on 08/06/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
class SignUpViewController: UIViewController {

    @IBOutlet var emailText: UITextField!
    @IBOutlet var passWordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "iphone_LMain")!)
        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToLoginView(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("LoginViewID") as! LoginViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func facebookButtonAction(sender: AnyObject) {
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
                    Services.sharedInstance().postmethod(result.valueForKey("name") as? String, email: result.valueForKey("email") as? String)
                    let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("TabBarID") as! UITabBarController
                    self.navigationController?.pushViewController(nextViewController, animated: true)
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
    

    @IBAction func cancelButtonAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func signUpButtonAction(sender: AnyObject) {
 
        if self.emailText.text  != "" || self.passWordTxt.text != ""
        {
            Services.sharedInstance().postmethod(self.emailText.text, email: self.emailText.text)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)//TabBarID
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("TabBarID") as! UITabBarController
            self.navigationController?.pushViewController(nextViewController, animated: true)
            NSUserDefaults.standardUserDefaults().setObject("12345", forKey: "USER_ID")

        }else{
            
            let actionSheetController: UIAlertController = UIAlertController(title: "Error", message: "Please enter required fields", preferredStyle: .Alert)
            
            //Create and add the Cancel action
            let cancelAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            actionSheetController.addAction(cancelAction)
            // let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) { action -> Void in
            //Code for picking from camera roll goes here
            
            actionSheetController.popoverPresentationController?.sourceView = self.view
            actionSheetController.popoverPresentationController?.sourceRect = self.view.bounds
            // this is the center of the screen currently but it can be any point in the view
            
            self.presentViewController(actionSheetController, animated: true, completion: nil)
            
        }

        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
