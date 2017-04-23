//
//  PageContainerViewController.swift
//  PayItForward
//
//  Created by Pankaj Khillon on 4/21/17.
//  Copyright © 2017 PayItFoward. All rights reserved.
//

import UIKit

class PageContainerViewController: UIPageViewController {
    
    var pageViewControllers: [UIViewController]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        let firstVC = storyboard!.instantiateViewController(withIdentifier: "firstPage")
        let secondVC = storyboard!.instantiateViewController(withIdentifier: "secondPage")
        let thirdVC = storyboard!.instantiateViewController(withIdentifier: "thirdPage")
        
        pageViewControllers = [firstVC, secondVC, thirdVC]
        
        if let firstVC = pageViewControllers.first {
            setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PageContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pageViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard pageViewControllers.count > previousIndex else {
            return nil
        }
        
        return pageViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pageViewControllers.index(of: viewController) else {
            return nil
        }
        
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pageViewControllers.count else {
            return nil
        }
        
        guard pageViewControllers.count > 0 else {
            return nil
        }
        
        return pageViewControllers[nextIndex]
    }
}
