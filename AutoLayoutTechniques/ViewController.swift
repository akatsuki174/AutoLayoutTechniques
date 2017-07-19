//
//  ViewController.swift
//  AutoLayoutTechniques
//
//  Created by akatsuki174 on 2017/07/19.
//  Copyright © 2017年 akatsuki174. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wrappingView: UIView!
    @IBOutlet weak var edgeConstraint: NSLayoutConstraint!
    var zeroHeightConstraint: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        wrappingView.clipsToBounds = true
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toggleDistanceControls(_ sender: Any) {
        if zeroHeightConstraint == nil {
            zeroHeightConstraint = wrappingView.heightAnchor.constraint(equalToConstant: 0)
        }
        
        let shouldShow = !edgeConstraint.isActive
        
        if shouldShow {
            zeroHeightConstraint.isActive = false
            edgeConstraint.isActive = true
        } else {
            edgeConstraint.isActive = false
            zeroHeightConstraint.isActive = true
        }
        
        UIView.animate(withDuration: 0.25) { 
            self.view.layoutIfNeeded()
        }
    }

}

