import Foundation
import UIKit
import SwiftEntryKit
import TripiHotelCoreSdk

protocol PopupShowable: AnyObject {
    func showPopupSort(data: PopupSortHotelDataSource, callBack: ((SortOptionEntity) -> Void)?)
    func showPopupTagHotel(tag: TagEntity)
    func showCenterPopupDescription(kind: PopupCenterDescriptionKind)
    
    func showPopupSelectHour(timeDefault: String, completed: ((String) -> Void)?)
    func showPopupLockup(time: String, didAccept: ((String?) -> Void)?)
}

extension PopupShowable where Self: UIViewController {
    func showPopupSort(data: PopupSortHotelDataSource, callBack: ((SortOptionEntity) -> Void)?) {
        let attributes = PopupAttributes.bottomSheetAttrs()
        let sortView = PopupSelectSortHotel()
        sortView.loadData(data: data)
        sortView.sortSelected = { typeSelected in
            SwiftEntryKit.dismiss()
            callBack?(typeSelected)
        }
        SwiftEntryKit.display(entry: sortView, using: attributes)
    }
    
    func showCenterPopupDescription(kind: PopupCenterDescriptionKind) {
        let attributes = PopupAttributes.centerAttrs()
        let centerView = PopupCenterDescription(frame: .zero)
        centerView.loadData(kind: kind)
        SwiftEntryKit.display(entry: centerView, using: attributes)
    }
    
    func showPopupTagHotel(tag: TagEntity) {
        let attributes = PopupAttributes.centerAttrs()
        let centerView = PopupTagsHotel(frame: .zero)
        centerView.loadData(data: tag)
        SwiftEntryKit.display(entry: centerView, using: attributes)
    }
    
    func showPopupSelectHour(timeDefault: String, completed: ((String) -> Void)?) {}
    
    func showPopupLockup(time: String, didAccept: ((String?) -> Void)?) {}
}

extension PopupShowable where Self: UINavigationController {
    func showPopupSelectHour(timeDefault: String, completed: ((String) -> Void)?) {
        let attributes = PopupAttributes.bottomSheetAttrs()
        let sortView = PopupSelectedHour()
        sortView.loadData(timeDefault: timeDefault)
        sortView.didSelectHour = completed
        SwiftEntryKit.display(entry: sortView, using: attributes)
    }
    
    func showPopupLockup(time: String, didAccept: ((String?) -> Void)?) {
        let attributes = PopupAttributes.centerAttrs()
        let popup = PopupLockupPicker()
        popup.loadData(time: time)
        popup.didAccept = { isAccept in
            SwiftEntryKit.dismiss()
            didAccept?(isAccept)
        }
        SwiftEntryKit.display(entry: popup, using: attributes)
    }
}