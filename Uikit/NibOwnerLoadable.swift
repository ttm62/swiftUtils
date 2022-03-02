//
//  NibOwnerLoadable.swift
//  TripiHotel
//
//  Created by Tripi on 31/05/2021.
//

import UIKit

protocol NibOwnerLoadable: AnyObject {
    static var nib: UINib { get }
}

extension NibOwnerLoadable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self),
                     bundle: Bundle(for: self).resource)
    }
}

// MARK: Support for instantiation from NIB
extension NibOwnerLoadable where Self: UIView {
    func loadViewFromNib() {
        let layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]
        for case let view as UIView in type(of: self).nib.instantiate(withOwner: self, options: nil) {
            view.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(view)
            NSLayoutConstraint.activate(layoutAttributes.map { attribute in
                NSLayoutConstraint(
                    item: view, attribute: attribute,
                    relatedBy: .equal,
                    toItem: self, attribute: attribute,
                    multiplier: 1, constant: 0.0
                )
            })
        }
    }
}
