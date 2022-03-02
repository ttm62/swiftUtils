import Foundation
import UIKit
import SwiftEntryKit

/// Show Toast
protocol ToastShowable: AnyObject {
    ///Simple toast
    func showToastSimpleMessage(type: ToastMessageType, verticalOffset: CGFloat?)
    ///Custom toast
    func showToastFavourite(isFavourite: Bool, callBack: @escaping () -> Void)
}

extension ToastShowable where Self: UIViewController {
    
    func showToastSimpleMessage(type: ToastMessageType, verticalOffset: CGFloat? = nil) {
        let text = type.message
        let style = EKProperty.LabelStyle(
            font: Fonts.medium(with: 14),
            color: .white,
            alignment: .left
        )
        let labelContent = EKProperty.LabelContent(
            text: text,
            style: style
        )
        
        let contentView = EKNoteMessageView(with: labelContent)
        contentView.backgroundColor = type.backgroundColor
        contentView.layer.cornerRadius = 5
        contentView.verticalOffset = 8
        var attributes = ToastAttributes.attrsBottomToast(verticalOffset: verticalOffset)
        attributes.displayDuration = 2
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    /// Show popup favourite
    func showToastFavourite(isFavourite: Bool, callBack: @escaping () -> Void) {
        var attributes = ToastAttributes.attrsBottomToast()
        attributes.entryInteraction.customTapActions.append(callBack)
        let favouriteToast = FavouriteBottomToastView(frame: .zero)
        favouriteToast.loadData(isFavourite: isFavourite)
        SwiftEntryKit.display(entry: favouriteToast, using: attributes)
    }
}
