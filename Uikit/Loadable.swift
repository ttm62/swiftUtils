//
//  Loading animation for UIViewController
// 
//  Created by david on 24/02/2022.
//

import Foundation
import UIKit

/**
 Any class conforming to the Loadable protocol
 will have to implement these two methods
 
     class MyViewController: UIViewController, Loadable {
         override func viewDidAppear(_ animated: Bool) {
             super.viewDidAppear(animated)
             
             showLoadingView()
             DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
                 /// ... 3 seconds later
                 self.hideLoadingView()
             }
         }
     }
 */
protocol Loadable {
    func showLoadingView()
    func hideLoadingView()
}

final
class DefaultLoading: UIView {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override
    func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        layer.cornerRadius = 16
        
        if activityIndicator.superview == nil {
            addSubview(activityIndicator)
            
            activityIndicator.color = .white
            
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
            activityIndicator.startAnimating()
        }
    }
    
    public
    func animate() {
        activityIndicator.startAnimating()
    }
}

fileprivate
struct Constants {
    /// an arbitrary tag id for the loading view, so it can be retrieved later without keeping a reference to it
    fileprivate static let loadingViewTag = 1234
}

extension Loadable where Self: UIViewController {
    func showLoadingView() {
        let loadingView = DefaultLoading()
        view.addSubview(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        loadingView.animate()
        
        loadingView.tag = Constants.loadingViewTag
    }
    
    func hideLoadingView() {
        view.subviews.forEach { subview in
            if subview.tag == Constants.loadingViewTag {
                subview.removeFromSuperview()
            }
        }
    }
}
