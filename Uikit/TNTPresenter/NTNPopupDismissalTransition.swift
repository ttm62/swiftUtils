//
//  NTNPopupDismissalTransition.swift
//  Mytour-ios
//
//  Created by ThinhNT on 08/02/2021.
//  Copyright © 2021 vn.Mytour. All rights reserved.
//

import UIKit

class NTNPopupDismissalTransition: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TNTConfiguration.shared.animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!

        let animationDuration = transitionDuration(using: transitionContext)

        UIView.animate(
            withDuration: animationDuration,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.8,
            options: [.curveEaseOut],
            animations: {
                fromViewController.view.alpha = 0
            }, completion: { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
}
