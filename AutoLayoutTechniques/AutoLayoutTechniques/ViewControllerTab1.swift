//
//  ViewController.swift
//  AutoLayoutTechniques
//
//  Created by akatsuki174 on 2017/07/19.
//  Copyright © 2017年 akatsuki174. All rights reserved.
//

import UIKit

class ViewControllerTab1: UIViewController {
    
    @IBOutlet var wrappingView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var dynamicTypeLabel: UILabel!
    // weakを付けた場合、一度isActive = falseにしてしまうと制約がnilになってしまう
    // のでここではweakを外している。
    // 参考：https://stackoverflow.com/questions/38051879/why-weak-iboutlet-nslayoutconstraint-turns-to-nil-when-i-make-it-inactive
    @IBOutlet var edgeConstraint: NSLayoutConstraint!
    @IBOutlet var topConstraint: NSLayoutConstraint! // edgeConstraintの代わりにこちらを使っても。
    var zeroHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setDynamicLabelFont()
    }
    
    func setDynamicLabelFont() {
        if #available(iOS 10.0, *) {
            dynamicTypeLabel.adjustsFontForContentSizeCategory = true
            dynamicTypeLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        } else {
            // 設定アプリで変更しても自動では変わらないのでNotificationで検知する
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil, queue: nil, using: { _ in
                self.dynamicTypeLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func transform(for translation: CGPoint) -> CGAffineTransform {
        let moveBy = CGAffineTransform(translationX: translation.x, y:  translation.y)
        let rotation = -sin(translation.x / (cardView.frame.width * 4.0))
        return moveBy.rotated(by: rotation)
    }
    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .changed:
            let translation = sender.translation(in: cardView.superview)
            cardView.transform = transform(for: translation)
        case .ended:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: [], animations: {
                self.cardView.transform = .identity
            }, completion: nil)
        default:
            break
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
    }
}

