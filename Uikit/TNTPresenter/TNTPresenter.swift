//
//  TNTPresenter.swift
//  Mytour-ios
//
//  Created by ThinhNT on 08/02/2021.
//  Copyright © 2021 vn.Mytour. All rights reserved.
//

import UIKit

struct SafeArea {
    static var top: CGFloat {
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.keyWindow else { return 0 }
            return window.safeAreaInsets.top
        } else {
            return 0
        }
    }
    
    static var bottom: CGFloat {
        if #available(iOS 11.0, *) {
            guard let window = UIApplication.shared.keyWindow else { return 0 }
            return window.safeAreaInsets.bottom
        } else {
            return 0
        }
    }
}


class TNTPresenter: NSObject {
    private weak var containerViewController: UIViewController!
    private weak var contentViewController: UIViewController!
    private var contentView: UIView! { return contentViewController.view }
    private var originContentViewFrame: CGRect!
    
    private var canGoMaxSize = false
    private var scrollView: UIScrollView? { (contentViewController as? TNTBottomSheetContentHasScrollViewProtocol)?.scrollView }
    private var scrollViewOldOffset: CGPoint?
    
    private let dismissButton = UIButton(frame: CGRect(x: (UIScreen.main.bounds.width - 42) / 2, y: 13, width: 42, height: 5))
    private weak var backgroundView: UIView?
    
    private var transitioningDelegate: UIViewControllerTransitioningDelegate?
    
    private var bottomSheetMaxFrame: CGRect {
        let top = UIApplication.shared.statusBarFrame.height > 20 ? UIApplication.shared.statusBarFrame.height : 40
        let height = UIScreen.main.bounds.height - (top + SafeArea.bottom)
        let width = UIScreen.main.bounds.width
        return CGRect(x: 0, y: top, width: width, height: height)
    }
    
    private var popupMaxFrame: CGRect {
        let topPadding: CGFloat = 40
        let leftPadding: CGFloat = 20
        let height = UIScreen.main.bounds.height - (SafeArea.top + SafeArea.bottom) - (2 * topPadding)
        let width = UIScreen.main.bounds.width - (2 * leftPadding)
        return CGRect(x: leftPadding, y: SafeArea.top + topPadding, width: width, height: height)
    }
    
    var panToDismissEnable: Bool = true {
        didSet { backgroundView?.isUserInteractionEnabled = panToDismissEnable }
    }
    
    init(configuration: TNTConfiguration? = nil) {
        if let configuration = configuration {
            TNTConfiguration.shared = configuration
        }
        super.init()
    }
    
    /**
     Presents a bottom sheet view controller embedded in a navigation controller.
     - parameter viewController:          The presented view controller.
     - parameter containerViewController: The presenting view controller.
     */
    func present(_ viewController: UIViewController,
                        on containerViewController: UIViewController,
                        style: PresentStyle,
                        isMaxSize: Bool = false,
                        panToDismissEnable: Bool = true) {
        
        self.panToDismissEnable = panToDismissEnable
        
        guard contentViewController?.viewIfLoaded?.window == nil else {
            contentViewController.dismiss(animated: true) {
                self.present(viewController, on: containerViewController, style: style, isMaxSize: isMaxSize,
                             panToDismissEnable: panToDismissEnable)
            }
            return
        }
        
        self.containerViewController = containerViewController
        self.contentViewController = viewController
        self.canGoMaxSize = false
        
        transitioningDelegate = TNTViewControllerTransitioningDelegate(style: style)
        viewController.transitioningDelegate = transitioningDelegate
        viewController.modalPresentationStyle = .custom
        
        switch style {
        case .popup:
            popupPresent(viewController, on: containerViewController)
        case .bottomSheet:
            bottomSheetPresent(viewController, on: containerViewController, isMaxSize)
        }
    }
    
    private func popupPresent(_ viewController: UIViewController,
                              on containerViewController: UIViewController) {
        
        let frame = calculateInitFrameForPopup()
        viewController.view.frame = frame
        containerViewController.present(viewController, animated: true, completion: nil)
    }

    private func bottomSheetPresent(_ viewController: UIViewController,
                                    on containerViewController: UIViewController,
                                    _ isMaxSize: Bool = false) {
        
        guard !(viewController is UINavigationController) else {
            assertionFailure("Presenting 'UINavigationController' in a bottom sheet is not supported.")
            return
        }
        
        let frame = calculateInitFrameForBottomSheet(maxSizable: isMaxSize)
        viewController.view.frame = frame
        
        addGesture(for: viewController.view)
        addDismissButton(to: viewController.view)
        addBottomPaddingView()
        
        containerViewController.present(viewController, animated: true, completion: {
            self.scrollView?.panGestureRecognizer.addTarget(self, action: #selector(self.handlePanGesture(_:)))
            if let backgroundView = (self.transitioningDelegate as? TNTViewControllerTransitioningDelegate)?
                .presentationController?.backgroundView {
                self.backgroundView = backgroundView
                self.canGoMaxSize = self.scrollView != nil
                    && self.contentView.frame.height < self.bottomSheetMaxFrame.height
                    && (self.scrollView?.frame.height ?? 0) < (self.scrollView?.contentSize.height ?? 0)
                self.addGesture(for: backgroundView)
                
                backgroundView.isUserInteractionEnabled = self.panToDismissEnable
            }
        })
    }
    
    private func calculateInitFrameForPopup() -> CGRect  {
        var frameAtInit: CGRect = popupMaxFrame
        
        contentViewController.view.setNeedsLayout()
        contentViewController.view.layoutIfNeeded()
        let size = contentViewController.view
            .systemLayoutSizeFitting(CGSize(width: frameAtInit.width, height: frameAtInit.height))
        
        if size.height < frameAtInit.height {
            frameAtInit.origin.y += ((frameAtInit.height - size.height) / 2)
            frameAtInit.size.height = size.height
        }
        
        if size.width < frameAtInit.width {
            frameAtInit.origin.x += ((frameAtInit.width - size.width) / 2)
            frameAtInit.size.width = size.width
        }
        
        return frameAtInit
    }
    
    private func calculateInitFrameForBottomSheet(maxSizable: Bool = false) -> CGRect {
        var frameAtInit: CGRect = bottomSheetMaxFrame
        if !maxSizable {
            frameAtInit.origin.y += TNTConfiguration.shared.minimumTopSpacing
            frameAtInit.size.height -= TNTConfiguration.shared.minimumTopSpacing
        }
        
        contentViewController.view.setNeedsLayout()
        contentViewController.view.layoutIfNeeded()
        let size = contentViewController.view
            .systemLayoutSizeFitting(CGSize(width: frameAtInit.width, height: frameAtInit.height))
        
        if size.height < frameAtInit.height {
            frameAtInit.origin.y += (frameAtInit.height - size.height)
            frameAtInit.size.height = size.height
        }
        
        return frameAtInit
    }
    
    private func addBottomPaddingView() {
        guard #available(iOS 11.0, *) else { return }
        contentView.clipsToBounds = false
        let radius = contentView.cornerRadiusValue
        let bottomView = UIView(frame: CGRect(x: 0, y: (0 - radius),
                                              width: bottomSheetMaxFrame.width,
                                              height: SafeArea.bottom + radius))
        bottomView.backgroundColor = contentView.backgroundColor
        contentView.insertSubview(bottomView, at: 0)
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: radius).isActive = true
        bottomView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                           constant: SafeArea.bottom).isActive = true
    }
    
    @objc private func dismissButtonHandler() {
        self.contentViewController.dismiss(animated: true, completion: nil)
    }
    
    private func addDismissButton(to contentView: UIView) {
        guard panToDismissEnable else { return }
        
        dismissButton.addTarget(self, action: #selector(dismissButtonHandler), for: .touchUpInside)
        dismissButton.backgroundColor = UIColor(hex: "#CBD5E0")
        dismissButton.cornerRadiusValue = dismissButton.frame.height / 2
        contentView.addSubview(dismissButton)
    }
    
    private func addGesture(for contentView: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        contentView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {
        guard panToDismissEnable else { return }
        
        let isPanOnBackgroundView = panGesture.view === backgroundView
        let isPanOnScrollView = panGesture === scrollView?.panGestureRecognizer
        
        let translation = panGesture.translation(in: containerViewController.view)
        let velocity = panGesture.velocity(in: containerViewController.view)
        var translationY = translation.y
        let velocityY = velocity.y
        
        let maxHeight = bottomSheetMaxFrame.height
        
        if isPanOnBackgroundView {
            let panSpacing = panGesture.location(in: backgroundView).y - (originContentViewFrame ?? contentView!.frame).origin.y
            if panSpacing <= 0 {
                translationY = 0
            } else {
                translationY = panSpacing
            }
        }
        
        switch panGesture.state {
        case .began:
            originContentViewFrame = contentView!.frame
            scrollViewOldOffset = scrollView?.contentOffset
            
        case .changed:
            guard translationY > 0 else {
                if canGoMaxSize {
                    if contentView.frame.height < maxHeight {
                        contentView!.frame = frameForMove(.up, with: translationY)
                        scrollView?.contentOffset.y = 0
                    }
                } else {
                    contentView?.frame = originContentViewFrame
                }
                break
            }
            
            var tranY = translationY
            let topOffset = CGPoint(x: -(scrollView?.contentInset.left ?? 0), y: -(scrollView?.contentInset.top ?? 0))
            if isPanOnScrollView {
                if (scrollView?.contentOffset.y ?? 0) > 0 {
                    if velocityY >= 0 {
                        break
                    }
                    
                    tranY -= (scrollViewOldOffset?.y ?? 0)
                    if tranY >= 0 {
                        scrollView?.setContentOffset(topOffset, animated: false)
                    }
                }
                else {
                    tranY -= (scrollViewOldOffset?.y ?? 0)
                    scrollView?.setContentOffset(topOffset, animated: false)
                }
            }
            
            scrollView?.setContentOffset(topOffset, animated: false)
            contentView!.frame = frameForMove(.down, with: tranY)
            
        case .ended, .cancelled:
            
            if canGoMaxSize, velocityY < 0, !isPanOnBackgroundView {
                originContentViewFrame = bottomSheetMaxFrame
            }
            
            if isPanOnScrollView && (scrollView?.contentOffset.y ?? 0) > 0 {
                resetContentView(from: translationY)
                break
            }
            
            switch considerEndFrame(tranY: translationY, velocityY: velocityY, originFrame: originContentViewFrame) {
            case .reset:
                resetContentView(from: translationY)
            case .dismiss:
                contentViewController.dismiss(animated: true, completion: nil)
            }
            
        default: break
        }
    }
    
    private func resetContentView(from translationY: CGFloat) {
        guard let originFrame = originContentViewFrame else { return }
        guard self.contentView?.frame.origin.y != originFrame.origin.y else { return }
        var duration = TNTConfiguration.shared.animationDuration * Double(translationY) / Double(originFrame.height)
        if duration < 0.1 {
            duration = 0.1
        }
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseOut], animations: {
            self.contentView?.frame = originFrame
        }, completion: nil)
    }
}

extension TNTPresenter {
    fileprivate enum EndingPanFrameType {
        case reset
        case dismiss
    }
    
    fileprivate func considerEndFrame(tranY: CGFloat, velocityY: CGFloat, originFrame: CGRect) -> EndingPanFrameType {
        var type = EndingPanFrameType.dismiss
        let speedLim: CGFloat = 30
        if velocityY < -speedLim {
            type = .reset
        } else if velocityY < speedLim && tranY < originFrame.height / 2 {
            type = .reset
        } else if tranY < 80 {
            type = .reset
        }
        
        return type
    }
    
    fileprivate enum MoveContentDirection {
        case up
        case down
    }
    
    fileprivate func frameForMove(_ direction: MoveContentDirection, with tranY: CGFloat) -> CGRect {
        guard var frame = originContentViewFrame else { return .zero }
        switch direction {
        case .up:
            guard tranY < 0 else { break }
            frame.origin.y += tranY
            frame.size.height += -tranY
            if frame.height > bottomSheetMaxFrame.height {
                frame = bottomSheetMaxFrame
            }
        case .down:
            guard tranY > 0 else { break }
            frame.origin.y += tranY
        }
        return frame
    }
}
