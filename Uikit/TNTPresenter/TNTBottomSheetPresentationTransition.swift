//
//  TNTBottomSheetPresentationTransition.swift
//  Mytour-ios
//
//  Created by ThinhNT on 08/02/2021.
//  Copyright © 2021 vn.Mytour. All rights reserved.
//

import UIKit

class TNTBottomSheetPresentationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TNTConfiguration.shared.animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView

        let animationDuration = transitionDuration(using: transitionContext)

        toViewController.view.transform = CGAffineTransform(translationX: 0, y: toViewController.view.frame.height)
        toViewController.view.layer.shadowColor = UIColor.black.cgColor
        toViewController.view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        toViewController.view.layer.shadowOpacity = 0.3

        containerView.addSubview(toViewController.view)
        
        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.8,
            options: [.curveEaseOut],
            animations: {
                toViewController.view.transform = CGAffineTransform.identity
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            }
        )
    }
}
