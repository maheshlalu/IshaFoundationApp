//
//  ViewController.swift
//  UniversalApp
//
//  Created by Rama kuppa on 31/05/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var bgImageView: UIImageView!
    let loginBtn : UIButton = UIButton()
    let signUpBtn : UIButton = UIButton()
    
    let pageImageFile : [String] = ["login1","login2","login1"]

     var pageControl: UIPageViewController = UIPageViewController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpPageController()
       // self.bgImageView.image = UIImage(named: self.pageImageFile[0])

        //self.view.backgroundColor = UIColor.blackColor()

        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpPageController(){
        
        self.pageControl = (self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as?UIPageViewController)!
        self.pageControl.dataSource = self
        let startingViewController: LoginPageViewController = self.viewControllerAtIndex(0)
        let viewControllers: [UIViewController] = [startingViewController]
        
        self.pageControl.setViewControllers(viewControllers as [UIViewController], direction: .Forward, animated: false, completion: nil)
        self.addChildViewController(self.pageControl)
        self.view.addSubview(self.pageControl.view)
        self.pageControl.didMoveToParentViewController(self)
        
        //self.pageControl.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100)
        
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


}

extension ViewController:UIPageViewControllerDataSource{
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index: Int = ((viewController as! LoginPageViewController)).pageIndex
        //self.bgImageView.image = UIImage(named: self.pageImageFile[index])

        if index == NSNotFound  {
            return nil
        }
        index += 1
        if index == self.pageImageFile.count {
            return nil
        }
        return self.viewControllerAtIndex(index)

    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index: Int = ((viewController as! LoginPageViewController)).pageIndex
       // self.bgImageView.image = UIImage(named: self.pageImageFile[index])

        if index == NSNotFound || index == 0 {
            return nil
        }
        index -= 1
        if index == self.pageImageFile.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> LoginPageViewController {
        if (self.pageImageFile.count == 0) || (index >= self.pageImageFile.count) {
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
extension UIColor {
    static func randomColor() -> UIColor {
        // If you wanted a random alpha, just create another
        // random number for that too.
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

