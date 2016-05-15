//
//  OnboardingPager.swift
//  Ophelia
//
//  Created by Chase Swanstrom on 5/6/16.
//  Copyright © 2016 Chase Swanstrom. All rights reserved.
//

import Foundation
import UIKit

class OnboardingPager : UIPageViewController {
    
    func getStepZero() -> StepZero {
        return storyboard!.instantiateViewControllerWithIdentifier("StepZero") as! StepZero
    }
    
    func getStepOne() -> StepOne {
        return storyboard!.instantiateViewControllerWithIdentifier("StepOne") as! StepOne
    }
    
    func getStepTwo() -> StepTwo {
        return storyboard!.instantiateViewControllerWithIdentifier("StepTwo") as! StepTwo
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .darkGrayColor()
        dataSource = self
        setViewControllers([getStepZero()], direction: .Forward, animated: false, completion: nil)
    }
    
}

extension OnboardingPager : UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(StepTwo) {
            return getStepOne()
        } else if viewController.isKindOfClass(StepOne) {
            return getStepZero()
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(StepZero) {
            return getStepOne()
        } else if viewController.isKindOfClass(StepOne) {
            return getStepTwo()
        } else {
            return nil
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}