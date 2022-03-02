//
//  TNTViewControllerTransitioningDelegate.swift
//  Mytour-ios
//
//  Created by ThinhNT on 08/02/2021.
//  Copyright © 2021 vn.Mytour. All rights reserved.
//

import UIKit

class TNTViewControllerTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    private(set) var style: PresentStyle
    private(set) var presentationController: TNTPresentationController?
    
    init(style: PresentStyle) {
        self.style = style
        super.init()
    }
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        presentationController = TNTPresentationController(presentedViewController: presented, presenting: presenting)
        return presentationController
    }

    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch style {
        case .popup: return NTNPopupPresentationTransition()
        case .bottomSheet: return TNTBottomSheetPresentationTransition()
        }
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch style {
        case .popup: return NTNPopupDismissalTransition()
        case .bottomSheet: return nil
        }
    }
}
