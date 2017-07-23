//
//  ViewControllerTab2.swift
//  AutoLayoutTechniques
//
//  Created by akatsuki174 on 2017/07/23.
//  Copyright © 2017年 akatsuki174. All rights reserved.
//

import UIKit

class ViewControllerTab2: UIViewController {
    private let sampleView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        sampleView.translatesAutoresizingMaskIntoConstraints = false
        sampleView.backgroundColor = .brown
        view.addSubview(sampleView)
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            sampleView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            sampleView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                sampleView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
                guide.bottomAnchor.constraintEqualToSystemSpacingBelow(sampleView.bottomAnchor, multiplier: 1.0)
            ])
        } else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                sampleView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
                bottomLayoutGuide.topAnchor.constraint(equalTo: sampleView.bottomAnchor, constant: standardSpacing)
            ])
        }
    }
    
}
