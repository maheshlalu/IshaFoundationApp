//
//  ViewController.swift
//  UniversalApp
//
//  Created by Rama kuppa on 31/05/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet var bottomBgView: UIView!
    @IBOutlet var LoginBtn: UIButton!
  
    @IBOutlet var SignUpBtn: UIButton!
   
    @IBOutlet weak var bgImageView: UIImageView!
    let loginBtn : UIButton = UIButton()
    let signUpBtn : UIButton = UIButton()
    
    let pageImageFile : [String] = ["page1","page2","page3"]//iphone_l1
    let iphone_landScape : [String] = ["iphone_l1","iphone_l2","iphone_l3"]
    let pageViewImages : NSMutableArray = NSMutableArray()
    

     var pageControl: UIPageViewController = UIPageViewController()
    

    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)

        
        
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgImageView.image = UIImage(named: self.pageImageFile[0])
        self.pageViewImages.addObjectsFromArray(self.pageImageFile)
        self.setUpPageController()
        self.navigationController?.navigationBarHidden = true
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default

        self.buttonBackGroundColor()
        
        
        //self.view.backgroundColor = UIColor.blackColor()

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func buttonBackGroundColor(){
        
        let borderAlpha : CGFloat = 0.7
        let cornerRadius : CGFloat = 5.0
        self.signUpBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.signUpBtn.backgroundColor = UIColor.clearColor()
        self.signUpBtn.layer.borderWidth = 1.0
        self.signUpBtn.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).CGColor
        self.signUpBtn.layer.cornerRadius = cornerRadius
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //LoginViewID
    }
    
    func setUpPageController(){
        
        let screenHt = UIScreen.mainScreen().bounds.size.height
        self.pageControl = (self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as?UIPageViewController)!
        self.pageControl.dataSource = self
        let startingViewController: LoginPageViewController = self.viewControllerAtIndex(0)
        let viewControllers: [UIViewController] = [startingViewController]
        
        self.pageControl.setViewControllers(viewControllers as [UIViewController], direction: .Forward, animated: false, completion: nil)
        self.addChildViewController(self.pageControl)
        self.view.addSubview(self.pageControl.view)
        self.pageControl.didMoveToParentViewController(self)
        
        self.pageControl.view.frame = CGRectMake(0, 0, self.view.frame.size.width, screenHt - self.bottomBgView.frame.size.height)
        
        //self.addContstraintToPageView()
    }
    
    func addContstraintToPageView(){
        self.pageControl.view.translatesAutoresizingMaskIntoConstraints = false
        
        //let verticalSpacing1 = NSLayoutConstraint(item: self.pageControl.view, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 10)
        
        let bottomLeftViewBottomConstraint = NSLayoutConstraint(item: self.pageControl.view, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal
            , toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 10)
        
        NSLayoutConstraint.activateConstraints( [bottomLeftViewBottomConstraint])
       // let verticalSpacing2 = NSLayoutConstraint(item: bottomRightView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: topRightView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 10)
        
        
    }

    //MARK: ButtonActions
    @IBAction func loginButtonAction(sender: AnyObject) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("LoginViewID") as! LoginViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func SignUpButtonAction(sender: AnyObject) {
        //TabBarID
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)//TabBarID
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("SignUpID") as! SignUpViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        if (toInterfaceOrientation.isLandscape) {
            NSLog("Landscape");
            self.pageViewImages.removeAllObjects()
            self.pageViewImages.addObjectsFromArray(self.iphone_landScape)
            self.bgImageView.image = UIImage(named: self.pageViewImages[0] as! String)
            self.viewControllerAtIndex(0)
            
        }
        else {
            NSLog("Portrait");
            self.pageViewImages.removeAllObjects()

            self.pageViewImages.addObjectsFromArray(self.pageImageFile)
            self.bgImageView.image = UIImage(named: self.pageViewImages[0] as! String)
            self.viewControllerAtIndex(0)
            
        }
    }

}

extension ViewController:UIPageViewControllerDataSource{
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index: Int = ((viewController as! LoginPageViewController)).pageIndex
        self.bgImageView.image = UIImage(named: self.pageViewImages[index] as! String)

        if index == NSNotFound  {
            return nil
        }
        index += 1
        if index == self.pageViewImages.count {
            return nil
        }
        return self.viewControllerAtIndex(index)

    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index: Int = ((viewController as! LoginPageViewController)).pageIndex
        self.bgImageView.image = UIImage(named: self.pageViewImages[index] as! String)

        if index == NSNotFound || index == 0 {
            return nil
        }
        index -= 1
        if index == self.pageViewImages.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> LoginPageViewController {
        if (self.pageViewImages.count == 0) || (index >= self.pageViewImages.count) {
            let tvc: LoginPageViewController? = nil
            return tvc!
        }
        // Create a new view controller and pass suitable data.
        let pageContentViewController: LoginPageViewController = (self.storyboard!.instantiateViewControllerWithIdentifier("PageContentViewController") as? LoginPageViewController)!
       // pageContentViewController.imgFile = self.arrPageImages[index]
       // pageContentViewController.txtTitle = self.arrPageTitles[index]
        pageContentViewController.pageIndex = index
        print("indext \(index)")
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return 3
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
}

/*
 let borderAlpha : CGFloat = 0.7
 let cornerRadius : CGFloat = 5.0
 
 button.frame = CGRectMake(100, 100, 200, 40)
 button.setTitle("Get Started", forState: UIControlState.Normal)
 button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
 button.backgroundColor = UIColor.clearColor()
 button.layer.borderWidth = 1.0
 button.layer.borderColor = UIColor(white: 1.0, alpha: borderAlpha).CGColor
 button.layer.cornerRadius = cornerRadius
 */

