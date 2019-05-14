//
//  PageController.swift
//  NNTabularViewController
//
//  Created by Nang Nguyen on 4/10/19.
//

import UIKit

typealias PageControllerTransition = (_ pageViewController: UIPageViewController, _ pageIndex: Int) -> Void

class PageController: NSObject, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    weak var pageViewController: UIPageViewController? {
        didSet {
            pageViewController?.delegate = self
            pageViewController?.dataSource = self
        }
    }
    
    private var viewControllers: [UIViewController] = []
    
    var didFinishTransition: PageControllerTransition?
    
    func showPage(_ index: Int, animated: Bool) {
        if (index >= 0 && index < self.viewControllers.count) {
            self.showViewController(self.viewControllers[index], animated: animated)
        }
    }
    
    func showViewController(_ viewController: UIViewController, animated: Bool) {
        let currentIndex: Int! = self.viewControllers.firstIndex(of: (self.pageViewController?.viewControllers!.last)!)
        let index: Int! = self.viewControllers.firstIndex(of: viewController)
        
        if (index == currentIndex) { return }
        
        let direction: UIPageViewController.NavigationDirection = index > currentIndex ? UIPageViewController.NavigationDirection.forward : UIPageViewController.NavigationDirection.reverse
        self.pageViewController?.setViewControllers([viewController], direction: direction, animated: animated, completion: { [weak self] (finished) in
            self?.perform(#selector(self?.refresh), with: nil, afterDelay: 0.05)
        })
        
    }
    
    func setViewControllers(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        self.pageViewController?.setViewControllers([viewControllers.first!],
                                                    direction: UIPageViewController.NavigationDirection.forward,
                                                    animated: false,
                                                    completion: nil)
    }
    
    @objc private func refresh() {
        self.pageViewController?.dataSource = self
    }
    
    // MARK: UIPageViewController delegate and data source
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = self.viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if (currentIndex <= 0) {
            return nil
        }
        
        return self.viewControllers[currentIndex-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = self.viewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        if (currentIndex >= self.viewControllers.count - 1) {
            return nil
        }
        return self.viewControllers[currentIndex+1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        didFinishTransition?(self.pageViewController!,self.viewControllers.firstIndex(of: pageViewController.viewControllers!.last!)!)
    }
    
}
