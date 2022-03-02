//
//  UIViewController+Ext.swift
//  prepaid
//
//  Created by Quang Trường on 11/06/2021.
//

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: Bundle(for: self))
        }
        
        return instantiateFromNib()
    }
    
    func add(_ child: UIViewController, in frame: CGRect) {
        addChild(child)
        child.view.frame = frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func showAlert(title: String = "Thông báo", message: String,
                   action: String = "OK",
                   handler:((UIAlertAction) -> Void)? = nil,
                   preferredStyle: UIAlertController.Style = .alert,
                   completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: UIAlertAction.Style.default, handler: handler))
        self.present(alert, animated: true, completion: completion)
    }
    
    func showAlert2(title: String = "Thông báo",
                   message: String,
                   positiveAction: String = "OK",
                   negativeAction: String = "Đóng",
                   positiveHandler:((UIAlertAction) -> Void)? = nil,
                   negativeHandler:((UIAlertAction) -> Void)? = nil,
                   preferredStyle: UIAlertController.Style = .alert,
                   completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: negativeAction, style: UIAlertAction.Style.default, handler: negativeHandler))
        alert.addAction(UIAlertAction(title: positiveAction, style: UIAlertAction.Style.default, handler: positiveHandler))
        self.present(alert, animated: true, completion: completion)
    }
    
    func showToast(message : String, font: UIFont = .systemFont(ofSize: 14)) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    // MARK: Present Modal
//    @available(iOS 15.0, *)
//    func presentModal(controller: UIViewController, detents: [UISheetPresentationController.Detent], preferCornerRadius: CGFloat?) {
//        if let sheet = controller.sheetPresentationController {
//            sheet.detents = detents
//            if let preferCornerRadius = preferCornerRadius {
//                sheet.preferredCornerRadius = preferCornerRadius
//            }
//        }
//        present(controller, animated: true)
//    }
    
    func presentVC(controller: UIViewController, on parentVC: BaseViewController, style: PresentStyle, canDismiss: Bool = true) {
        parentVC.customPresenter.present(controller, on: parentVC,
                                         style: style,
                                         isMaxSize: false,
                                         panToDismissEnable: canDismiss)
    }
}
