import UIKit

class BaseViewController: UIViewController {}

extension BaseViewController: StoryboardInstantiable,
                              NavigationBarConfigurable,
                              AlertShowable,
                              ToastShowable,
                              PopupShowable
{}
