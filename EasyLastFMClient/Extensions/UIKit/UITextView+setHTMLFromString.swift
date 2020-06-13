//
//  UITextView+setHTMLFromString.swift
//  Easy Last FM Client
//
//  Created by Artem Agafonov on 30.03.2020.
//  Copyright © 2020 Artem Agafonov. All rights reserved.
//

import UIKit.UITextView

extension UITextView {
    func setHTML(from string: String?) {
        guard let font = font,
            let color = textColor else {
            assertionFailure("No font or color provided")
            text = string
            return
        }
        guard let htmlString = string else {
            text = string
            return
        }
        let styled = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; " +
            "font-size: \(font.pointSize); color: \(color.hex)\">%@</span>", htmlString)
        if let attributedString = try? NSAttributedString(data: Data(styled.utf8),
                                                          options: htmlAttributes,
                                                          documentAttributes: nil) {
           attributedText = attributedString
        } else {
            text = string
        }
    }
}

// MARK: - Private
private extension UITextView {
    var htmlAttributes: [NSAttributedString.DocumentReadingOptionKey: Any] {
        [.documentType: NSAttributedString.DocumentType.html]
    }
}
