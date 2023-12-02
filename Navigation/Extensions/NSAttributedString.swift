import Foundation
import UIKit

extension NSAttributedString {
    
    private static func createAttributedString(string: String, fontName: String, size: CGFloat, kern: CGFloat, lineSpacing: CGFloat, alignment: NSTextAlignment) -> NSAttributedString {
        let font = UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .kern: kern,
            .paragraphStyle: paragraphStyle,
        ]
        
        return NSAttributedString(string: string, attributes: attributes)
    }
    
    static func gilroyBold(string: String, size: CGFloat, lineSpacing: CGFloat = 0, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return createAttributedString(string: string,
                                      fontName: "Gilroy-Bold",
                                      size: size,
                                      kern: -0.41,
                                      lineSpacing: lineSpacing,
                                      alignment: alignment)
    }
    
    static func gilroyRegular(string: String, size: CGFloat, lineSpacing: CGFloat = 0, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return createAttributedString(string: string,
                                      fontName: "Gilroy-Regular",
                                      size: size,
                                      kern: -0.1,
                                      lineSpacing: lineSpacing,
                                      alignment: alignment)
    }
    
    static func gilroySemiBold(string: String, size: CGFloat, lineSpacing: CGFloat = 0, alignment: NSTextAlignment = .left) -> NSAttributedString {
        return createAttributedString(string: string,
                                      fontName: "Gilroy-Semibold",
                                      size: size,
                                      kern: -0.41,
                                      lineSpacing: lineSpacing,
                                      alignment: alignment)
    }
}
