//
//  UIView+Ext.swift
//  prepaid
//
//  Created by Quang Trường on 11/06/2021.
//

import UIKit

extension UIView {
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.8
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 2
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.zPosition = 1
    }
    
    func cardView() {
        backgroundColor = .white
        layer.cornerRadius = 5.0
        layer.borderColor  =  UIColor.clear.cgColor
        layer.borderWidth = 5.0
        layer.shadowOpacity = 0.5
        layer.shadowColor =  UIColor.lightGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:5, height: 5)
        layer.masksToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func loadFromNib() {
        let name = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        guard let view = bundle.loadNibNamed(name, owner: self, options: nil)?.first as? UIView else {
            fatalError("Nib not found.")
        }
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        layoutAttachViewToSuperview(view: view)
    }
    
    func layoutAttachViewToSuperview(view: UIView) {
        let views = ["view" : view]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                   options: [],
                                                                   metrics: nil,
                                                                   views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: views)
        addConstraints(horizontalConstraints + verticalConstraints)
    }
}

//extension UIView {
//    @IBInspectable var shadowRadius: CGFloat {
//        get { return layer.shadowRadius }
//        set { layer.shadowRadius = newValue }
//    }
//
//    @IBInspectable var shadowOpacity: CGFloat {
//        get { return CGFloat(layer.shadowOpacity) }
//        set { layer.shadowOpacity = Float(newValue) }
//    }
//
//    @IBInspectable var shadowOffset: CGSize {
//        get { return layer.shadowOffset }
//        set { layer.shadowOffset = newValue }
//    }
//
//    @IBInspectable var shadowColor: UIColor? {
//        get {
//            guard let cgColor = layer.shadowColor else {
//                return nil
//            }
//            return UIColor(cgColor: cgColor)
//        }
//        set { layer.shadowColor = newValue?.cgColor }
//    }
//}

extension UIView {
    @IBInspectable
    var cornerRadiusValue: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
