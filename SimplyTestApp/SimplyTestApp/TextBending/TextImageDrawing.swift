//
//  TextImageDrawing.swift
//  CurvedTheText
//
//  Created by Iqbal Sheikh on 29/12/24.
//

import Foundation
import UIKit
import SwiftUI

// Helper functions to calculate radius and halfCircle (as you provided)

fileprivate func radius(c1: CGFloat, c2: CGFloat) -> CGFloat {
    return sqrt(pow(c1, 2) + pow(c2, 2))
}

fileprivate func halfCircle(x: CGFloat, r: CGFloat) -> CGFloat {
    return sqrt(pow(r, 2) - pow(x, 2))
}
//
//
func drawTextImage(text: String, inflection: CGFloat, size: CGSize, textFont: String,maskImage:UIImage,textColor:Color) -> UIImage {
    // Create a renderer with the given image size
    let format = UIGraphicsImageRendererFormat()
    format.scale = 1  // Adjust the scale as per your requirement
    let renderer = UIGraphicsImageRenderer(size: size, format: format)
    let uiTextColor = UIColor(textColor)

    // Render the image
    let image = renderer.image { rendererContext in
        let context = rendererContext.cgContext
        let chars = text.map { String($0) as NSString }
        
        // Calculate the appropriate font size based on the image size
        let maxWidth = size.width * 0.5  // Let the text take up 80% of the width of the image
        let maxHeight = size.height * 0.4 // Let the text take up 80% of the height of the image
        
        var fontSize: CGFloat = 20  // Start with a base font size
        
        // Load custom font
         let customFont = UIFont(name: textFont, size: fontSize) 
        
        // Calculate the bounding box of the text
        let nsText = text as NSString
        var textSize = nsText.size(withAttributes: [.font: customFont])
        
        // Adjust the font size dynamically based on the size of the image
        while textSize.width < maxWidth && textSize.height < maxHeight {
            fontSize += 1
            textSize = nsText.size(withAttributes: [.font: UIFont(name: textFont, size: fontSize)!])
        }
        
        // Make sure the text doesn't exceed the bounds
        if textSize.width > maxWidth {
            fontSize -= 1
        }
        
        // Update the font with the correct size
        let adjustedFont = UIFont(name: textFont, size: fontSize)!
        
        // Text attributes
        let attributes: [NSAttributedString.Key: Any] = [
            .font: adjustedFont,
            .foregroundColor: uiTextColor
        ]
        
        // Calculate the text's bounding box and center position
        let adjustedTextSize = nsText.size(withAttributes: attributes)
        let center = CGPoint(
            x: (size.width - adjustedTextSize.width) / 2,
            y: (size.height - adjustedTextSize.height) / 2
        )
        
        guard inflection != 0 else {
            // If no inflection is applied, simply draw the centered text
            nsText.draw(at: center, withAttributes: attributes)
            return
        }
       
        var startPoint = center
        let c2 = abs(inflection * adjustedTextSize.width / 2)
        let r = radius(c1: adjustedTextSize.width / 2, c2: c2)
        
        for c in chars {
            context.saveGState()
            
            let cSize = c.size(withAttributes: attributes)
            let x = (startPoint.x - center.x) - adjustedTextSize.width / 2
            let y = inflection * halfCircle(x: x, r: r)
            
            let xm = (startPoint.x + cSize.width / 2 - center.x) - adjustedTextSize.width / 2
            let ym = inflection * halfCircle(x: xm, r: r)
            
            let x2 = ((startPoint.x + cSize.width) - center.x) - adjustedTextSize.width / 2
            let y2 = inflection * halfCircle(x: x2, r: r)
            
            let m = (y2 - y) / (x2 - x)
            let theta: CGFloat = atan(m)
            
            startPoint.y = center.y + ym - inflection * c2

            context.translateBy(
                x: startPoint.x + cSize.width / 2,
                y: startPoint.y + cSize.height / 2
            )
            
            context.rotate(by: theta)
            
            // Draw the character
            c.draw(
                at: .init(
                    x: -cSize.width / 2,
                    y: -cSize.height / 2
                ),
                withAttributes: attributes
            )
            
            startPoint.x = startPoint.x + cSize.width
            context.restoreGState()
        }
    }
    
    return image
}
