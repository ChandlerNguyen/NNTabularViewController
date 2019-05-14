//
//  ViewController.swift
//  NNTabularViewController
//
//  Created by ChandlerNguyen on 05/14/2019.
//  Copyright (c) 2019 ChandlerNguyen. All rights reserved.
//

import UIKit
import NNTabularViewController

class ViewController: UIViewController {

    lazy var tabularViewController: NNTabularViewController = {
        let tabularViewController = NNTabularViewController(tabItems: [(title:"Segment 1", image: #imageLiteral(resourceName: "segment-1")),
                                                                       (title: "S 2", image: #imageLiteral(resourceName: "segment-2")),
                                                                       (title: "Long Text Segment 3", image: #imageLiteral(resourceName: "segment-3")),
                                                                       (title: "Seg 4", image: #imageLiteral(resourceName: "segment-4")),
                                                                       (title: "Segment 5", image: #imageLiteral(resourceName: "segment-5")),
                                                                       (title: "Segment 6", image: #imageLiteral(resourceName: "segment-6"))],
                                                            viewControllers: [ViewController1(),
                                                                              ViewController2(),
                                                                              ViewController3(),
                                                                              ViewController1(),
                                                                              ViewController2(),
                                                                              ViewController3()])
        tabularViewController.view.translatesAutoresizingMaskIntoConstraints = false
        return tabularViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.addSubview(tabularViewController.view)
        
        let constraints = [
            tabularViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabularViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabularViewController.view.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tabularViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

