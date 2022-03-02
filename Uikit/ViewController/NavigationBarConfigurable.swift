import UIKit

/// Navigation bar design editing.
protocol NavigationBarConfigurable {
    func setupNavigationBar(title: String,
                            subTitle: String?,
                            leftButtons: [(TPLeftBarButtonType, selector: Selector?)]?,
                            rightButtons: [(TPRightBarButtonType, selector: Selector?)]?,
                            tapTitleView: UITapGestureRecognizer?)
    
    func setupNavigationBarWithSearch(searchTf: UITextField,
                                      leftButtons: [(TPLeftBarButtonType, selector: Selector?)]?,
                                      rightButtons: [(TPRightBarButtonType, selector: Selector?)]?)
    func showNavigationBar()
    func hideNavigationBar()
}

extension NavigationBarConfigurable where Self: UIViewController {
    
    /// Set the title of the navigation bar
    ///
    /// - Parameter title: Title to set.
    /// - Parameter leftButtons: List left bar button
    /// - Parameter rightButtons: List right bar button
    func setupNavigationBar(title: String,
                            subTitle: String? = nil,
                            leftButtons: [(TPLeftBarButtonType, selector: Selector?)]? = nil,
                            rightButtons: [(TPRightBarButtonType, selector: Selector?)]? = nil,
                            tapTitleView: UITapGestureRecognizer? = nil)
    {
        self.navigationController?.navigationBar.tintColor = Colors.green
        if title.isEmpty {
            self.navigationItem.titleView = nil
        } else {
            let maxItemsCount = max(leftButtons?.count ?? 0, rightButtons?.count ?? 0)
            let titleWidth = UIScreen.main.bounds.size.width - CGFloat(maxItemsCount * 2 * 60)
            let titleView = UIView(frame: CGRect(x: 0, y: 0, width: titleWidth, height: 40))
            let titleLabel = MarqueeLabel(frame: CGRect(x: 0, y: 0, width: titleWidth, height: 24))
            titleLabel.textAlignment = .center
            
            titleLabel.text = title
            titleLabel.font = Fonts.medium(with: 16)
            titleLabel.textColor = Colors.grey900
            titleLabel.type = .continuous
            titleLabel.fadeLength = 10
            titleLabel.animationCurve = .easeInOut
            titleLabel.trailingBuffer = 50
            titleView.addSubview(titleLabel)
            if let subTitle = subTitle {
                let subLabel = UILabel(frame: CGRect(x: 0,
                                                     y: titleLabel.bounds.height,
                                                     width: titleWidth,
                                                     height: 16))
                subLabel.textAlignment = .center
                subLabel.text = subTitle
                subLabel.font = Fonts.regular(with: 12)
                subLabel.textColor = UIColor.darkGray
                titleView.addSubview(subLabel)
            } else {
                titleView.frame = CGRect(x: 0, y: 0, width: titleWidth, height: 24)
            }
            
            self.navigationItem.titleView = titleView
        }
        
        if let leftButtons = leftButtons, !leftButtons.isEmpty {
            self.navigationItem.leftBarButtonItems = leftButtons.map({ return self.createLeftBarButton(type: $0, selector: $1) })
        } else {
            self.navigationItem.leftBarButtonItems = nil
            self.navigationItem.hidesBackButton = true
        }
        
        if let rightButtons = rightButtons, !rightButtons.isEmpty {
            self.navigationItem.rightBarButtonItems = rightButtons.map({ return self.createRightBarButton(type: $0, selector: $1) })
        } else {
            self.navigationItem.rightBarButtonItems = nil
        }
        
        if let tapTitleView = tapTitleView {
            self.navigationItem.titleView?.addGestureRecognizer(tapTitleView)
        }
    }
    
    func setupNavigationBarWithSearch(searchTf: UITextField,
                                      leftButtons: [(TPLeftBarButtonType, selector: Selector?)]? = nil,
                                      rightButtons: [(TPRightBarButtonType, selector: Selector?)]? = nil) {
        self.navigationController?.navigationBar.tintColor = Colors.green
        let maxItemsCount = (leftButtons?.count ?? 0) + (rightButtons?.count ?? 0)
        let titleWidth = UIScreen.main.bounds.size.width - CGFloat(maxItemsCount * 60)
        searchTf.frame = CGRect(x: 0, y: 0, width: titleWidth, height: 40)
        self.navigationItem.titleView = searchTf
        
        if let leftButtons = leftButtons, !leftButtons.isEmpty {
            self.navigationItem.leftBarButtonItems = leftButtons.map({ return self.createLeftBarButton(type: $0, selector: $1) })
        } else {
            self.navigationItem.leftBarButtonItems = nil
            self.navigationItem.hidesBackButton = true
        }
        
        if let rightButtons = rightButtons, !rightButtons.isEmpty {
            self.navigationItem.rightBarButtonItems = rightButtons.map({ return self.createRightBarButton(type: $0, selector: $1) })
        } else {
            self.navigationItem.rightBarButtonItems = nil
        }
    }
    
    /// Show the navigation bar.
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    /// Hide the navigation bar.
    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    /// Navigation bar left BarButtonItem settings
    ///
    /// - Parameter type: Left bar button type.
    /// - Parameter selector: Action when left bar button is pressed.
    func createLeftBarButton(type: TPLeftBarButtonType, selector: Selector? = nil) -> UIBarButtonItem {
        switch type {
        case .back:
            let image = type.icon
            if let selector = selector {
                return UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
            } else {
                return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.pop))
            }
        case .close:
            let image = type.icon
            if let selector = selector {
                return UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
            } else {
                return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self._dismiss))
            }
        }
    }

    /// Navigation bar right BarButtonItem settings
    ///
    /// - Parameter type: Right bar button type.
    /// - Parameter selector: Action when right bar button is pressed.
    func createRightBarButton(type: TPRightBarButtonType, selector: Selector? = nil) -> UIBarButtonItem {
        switch type {
        case .close:
            let image = type.icon
            if let selector = selector {
                return UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
            } else {
                return UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(_dismiss))
            }
        default:
            let image = type.icon
            return UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
        }
    }
}