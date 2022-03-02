//
//  String+Utilitites.swift
//  Partner
//
//  Created by Quan Hoang on 3/14/19.
//  Copyright © 2019 Tripi. All rights reserved.
//

import UIKit
import TripiCommon

extension NSString {
    @objc func tpMatchRegex(_ regex: NSString) -> Bool {
        return (self as String).tpMatchRegex(regex as String)
    }
}

extension String {
    func dateWith(format: String, dateFormatter: DateFormatter = DateFormatter()) -> Date? {
        return Date().dateFromString(self, format)
    }
    
    var isEmail: Bool {
        let emailRegex = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        let isValid = emailTest.evaluate(with: self)
        return isValid
    }
    
    var isPhone: Bool {
        let phoneRegex = "(0|84|\\+84)+([0-9]{8,11})"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let isValid = phoneTest.evaluate(with: self)
        return isValid
    }
    
    var gender: String {
        if self.lowercased() == "m" {
            return "Nam"
        } else if self.lowercased() == "f" {
            return "Nữ"
        }
        return ""
    }
    
    var double: Double {
        return (self as NSString).doubleValue
    }
    
    var int: Int {
        return (self as NSString).integerValue
    }
    
    var ddmmyyyyRegex: String {
        return "^(3[0-1]|[1-2][0-9]|(?:0)[1-9])(?:-)(1[0-2]|(?:0)[1-9])(?:-)[1-9][0-9]{3}$"
    }
    
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func toAttributedString(font: UIFont = .regularFont(size: 14),
                            color: UIColor = .navigationTitleLabelColor,
                            imageWidth: CGFloat = 24,
                            contentWidth: CGFloat = 320) -> NSAttributedString? {
        let style =
        "<style>" +
            "body{" +
                "width: \(contentWidth)px;" +
                "text-align: justify;" +
                "color: \(color.hexString ?? "");" +
                "font-family: '\(font.fontName)';" +
                "font-size: \(font.pointSize)px;}" +
            "img{width: \(imageWidth)px;}" +
        "</style>"
        let content = "<html><head>\(style)</head><body>\(self)</body></html>"
        guard let data = content.data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    func isHasWhiteSpace() -> Bool {
        let whitespace = NSCharacterSet.whitespaces
        let range = self.rangeOfCharacter(from: whitespace)

        // range will be nil if no whitespace is found
        if range != nil {
            return true
        }
        return false
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSMakeRange(0, attributeString.length))
        return attributeString
	}

    func tpMatchRegex(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    var tpLocalized: String {
        return PPLocalizationSystem.sharedLocal().localizedString(forKey: self, value: self)
    }

    func setFontColor(for strings: [String], color: UIColor, font: UIFont? = nil) -> NSAttributedString? {
        let attributed = NSMutableAttributedString(string: self)
        strings.forEach { string in
            let range = (self as NSString).range(of: string)
            attributed.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            if let font = font {
                attributed.addAttributes([.font: font], range: range)
            }
        }
        return attributed
    }
}

extension NSAttributedString {
    @objc static func make(attrString: NSMutableAttributedString,
                           lineSpacing: CGFloat = 0,
                           alignment: NSTextAlignment = .left,
                           lineBreakMode: NSLineBreakMode = .byWordWrapping) -> NSMutableAttributedString? {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.lineSpacing = lineSpacing
        
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                value: paragraphStyle,
                                range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }
    
    @objc static func make(text: String?,
                           spacing: CGFloat,
                           font: UIFont,
                           color: UIColor,
                           lineSpacing: CGFloat = 0,
                           isUnderLine: Bool = false,
                           alignment: NSTextAlignment = .left,
                           lineBreakMode: NSLineBreakMode = .byWordWrapping) -> NSMutableAttributedString? {
        if text == nil {
            return nil
        }
        
        let attrString = NSMutableAttributedString()
        let attrStr = NSMutableAttributedString.getStyle(text ?? "",
                                                         font: font,
                                                         fontColor: color,
                                                         charSpacing: spacing,
                                                         isUnderLine: isUnderLine)
        attrString.append(attrStr)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.lineSpacing = lineSpacing
        
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                value: paragraphStyle,
                                range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }
    
    @objc static func make(text: String?,
                           font: UIFont,
                           color: UIColor) -> NSMutableAttributedString? {
        if text == nil {
            return nil
        }
        
        let attrString = NSMutableAttributedString()
        let attrStr = NSMutableAttributedString.getStyle(text ?? "",
                                                         font: font,
                                                         fontColor: color,
                                                         charSpacing: 0,
                                                         isUnderLine: false)
        attrString.append(attrStr)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                value: paragraphStyle,
                                range: NSRange(location: 0, length: attrString.length))
        
        return attrString
    }
}

extension NSMutableAttributedString {
    static func getStyle(_ inputString: String,
                         font: UIFont,
                         fontColor: UIColor,
                         charSpacing: CGFloat,
                         isUnderLine: Bool = false) -> NSMutableAttributedString {
        let textFont: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font,
                                                       NSAttributedString.Key.foregroundColor: fontColor,
                                                       NSAttributedString.Key.kern: charSpacing]
        let attrStr = NSMutableAttributedString(string: inputString, attributes: textFont)
        attrStr.addAttribute(NSAttributedString.Key.underlineStyle,
                             value: isUnderLine ? NSUnderlineStyle.single.rawValue : 0,
                             range: NSRange(location: 0, length: attrStr.length))
        return attrStr
    }
    
    func insertIcon(_ icon: UIImage, at: Int = 0, iconSize: CGFloat, iconYPost: CGFloat) {
        let attachment = NSTextAttachment()
        attachment.image = icon
        attachment.bounds = CGRect(x: 0.0, y: iconYPost,
                                   width: iconSize, height: iconSize)
        let attachmentString = NSAttributedString(attachment: attachment)
        self.insert(attachmentString, at: at)
    }
}

extension String {
    var utfData: Data {
        return Data(utf8)
    }

    var attributedHtmlString: NSAttributedString? {

        do {
            return try NSAttributedString(data: utfData,
            options: [
                      .documentType: NSAttributedString.DocumentType.html,
                      .characterEncoding: String.Encoding.utf8.rawValue
                     ], documentAttributes: nil)
        } catch {
            print("Error:", error)
            return nil
        }
    }
}
