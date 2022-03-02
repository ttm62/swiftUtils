import UIKit

public protocol AlertShowable {
    func showAlert(title: String, message: String?)
    func showAlert(title: String, message: String?, closeButtonTitle: String)
    func showAlert(title: String, message: String?, buttonTitle: String?, handler: ((UIAlertAction) -> Void)?, closeButtonTitle: String)
    func showError(message: String?)
}

public extension AlertShowable where Self: UIViewController {
    func showAlert(title: String, message: String?) {
        self.showAlert(title: title, message: message, closeButtonTitle: "Đóng")
    }
    
    func showAlert(title: String, message: String?, closeButtonTitle: String) {
        self.showAlert(title: title, message: message, buttonTitle: nil, handler: nil, closeButtonTitle: closeButtonTitle)
    }
    
    func showAlert(title: String, message: String?, buttonTitle: String?, handler: ((UIAlertAction) -> Void)?, closeButtonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
        let cancelAction = UIAlertAction(title: closeButtonTitle, style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        
        if let actionTitle = buttonTitle {
            let action = UIAlertAction(title: actionTitle, style: .default, handler: handler)
            alert.addAction(action)
        }
                
        self.present(alert, animated: true, completion: nil)
    }
    
    func showError(message: String?) {
        self.showAlert(title: "Lỗi", message: message, closeButtonTitle: "Đóng")
    }
}

public extension AlertShowable where Self: UINavigationController {
    func showAlert(title: String, message: String?) {
        self.showAlert(title: title, message: message, closeButtonTitle: "Đóng")
    }
    
    func showAlert(title: String, message: String?, closeButtonTitle: String) {
        self.showAlert(title: title, message: message, buttonTitle: nil, handler: nil, closeButtonTitle: closeButtonTitle)
    }
    
    func showAlert(title: String, message: String?, buttonTitle: String?, handler: ((UIAlertAction) -> Void)?, closeButtonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                
        let cancelAction = UIAlertAction(title: closeButtonTitle, style: .destructive, handler: nil)
        alert.addAction(cancelAction)
        
        if let actionTitle = buttonTitle {
            let action = UIAlertAction(title: actionTitle, style: .default, handler: handler)
            alert.addAction(action)
        }
                
        self.present(alert, animated: true, completion: nil)
    }
    
    func showError(message: String?) {
        self.showAlert(title: "Lỗi", message: message, closeButtonTitle: "Đóng")
    }
}