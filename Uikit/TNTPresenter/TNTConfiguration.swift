//
//  TNTConfiguration.swift
//  Mytour-ios
//
//  Created by ThinhNT on 08/02/2021.
//  Copyright © 2021 vn.Mytour. All rights reserved.
//

import UIKit

public struct TNTConfiguration {

    public static var shared = TNTConfiguration()
    
    public static let defaultAnimationDuration: TimeInterval = 0.3
    public var animationDuration: TimeInterval = 0.0
    public var minimumTopSpacing: CGFloat = 0.0

    public init(animationDuration: TimeInterval = defaultAnimationDuration,
                minimumTopSpacing: CGFloat = UIScreen.main.bounds.height * 1/5) {
        self.animationDuration = animationDuration
        self.minimumTopSpacing = minimumTopSpacing
    }
}

class TNTContentWrappingTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
}

class TNTContentWrappingCollectionView: UICollectionView {
    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
}

protocol TNTBottomSheetContentHasScrollViewProtocol {
    var scrollView: UIScrollView { get }
}

enum PresentStyle {
    case popup
    case bottomSheet
}
