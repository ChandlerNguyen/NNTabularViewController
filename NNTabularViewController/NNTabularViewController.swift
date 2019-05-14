//
//  NNTabularViewController.swift
//  NNTabularViewController
//
//  Created by Nang Nguyen on 5/14/19.
//

import UIKit
import NNScrollableSegmentedControl

public class NNTabularViewController: UIViewController {
    lazy private var segmentedControl: NNScrollableSegmentedControl = {
        let segmentedControl = NNScrollableSegmentedControl(frame: .zero)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.style = .textOnly
        segmentedControl.valueChanged = { [weak self] (selectedSegmentIndex) in
            self?.pageViewController.showPage(selectedSegmentIndex)
        }
        return segmentedControl
    }()
    
    lazy private var pageViewContainer: UIView = {
        let viewContainer = UIView(frame: .zero)
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        return viewContainer
    }()
    
    lazy private var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: UIPageViewController.NavigationOrientation.horizontal, options: nil)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        pageViewController.setDidFinishTransition { [weak self] (viewController, pageIndex) in
            self?.segmentedControl.selectedSegmentIndex = pageIndex
        }
        return pageViewController
    }()
    
    public init(tabItems:[(title: String, image: UIImage?)], viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        
        for index in 0...tabItems.count-1 {
            let tabItem = tabItems[index]
            segmentedControl.insertSegment(withTitle: tabItem.title, image: tabItem.image, at: index)
        }
        
        pageViewController.setViewControllers(viewControllers)
        segmentedControl.selectedSegmentIndex = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViewHierarchy()
        setupConstraints()

    }
    
    private func setupViewHierarchy() {
        view.addSubview(segmentedControl)
        view.addSubview(pageViewContainer)
        pageViewContainer.addSubview(pageViewController.view)
    }
    
    private func setupConstraints() {
        let constraints = [
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 50),
            
            pageViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewContainer.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            pageViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pageViewController.view.leadingAnchor.constraint(equalTo: pageViewContainer.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: pageViewContainer.trailingAnchor),
            pageViewController.view.topAnchor.constraint(equalTo: pageViewContainer.topAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: pageViewContainer.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
