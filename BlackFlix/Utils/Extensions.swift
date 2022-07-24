//
//  Utils.swift
//  BlackFlix
//
//  Created by Mushfiq Humayoon on 23/07/22.
//

import UIKit

extension UIView {
    public static func viewIdentifier() -> String {
        return String(describing: self)
    }
}
extension UILabel {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .light)], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}
