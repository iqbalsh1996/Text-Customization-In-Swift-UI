//
//  CurvedTextView.swift
//  CurvedTheText
//
//  Created by Iqbal Sheikh on 29/12/24.
//

import SwiftUI

struct CurvedTextView: View {
    @Binding var inflection: CGFloat  // Bind the inflection value
    @Binding var selectedFont: String
    @State var selectedImage: UIImage
    @Binding var enteredText: String
    @Binding var selectedColor: Color

    // Define a minimum size for the image
    private let minImageSize = CGSize(width: 200, height: 150)
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                // Use the width and height of the container to determine the size of the image
                let imageSize = CGSize(
                    width: max(minImageSize.width, geometry.size.width * 0.8),  // 80% of the container width
                    height: max(minImageSize.height, geometry.size.height * 0.6)  // 60% of the container height
                )

                Image(uiImage: drawTextImage(
                    text: "hello how are ",
                    inflection: inflection,
                    size: imageSize,
                    textFont: selectedFont,
                    maskImage: selectedImage,textColor: selectedColor
                ))
                .resizable()
                .scaledToFit()
            }
            .padding()
        }
    }
}
