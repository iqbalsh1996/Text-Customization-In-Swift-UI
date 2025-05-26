//
//  ColorPickerViewModel.swift
//  SimplyTestApp
//
//  Created by Iqbal Sheikh on 04/01/25.
//

import Foundation
import SwiftUI

class ColorPickerViewModel: ObservableObject {
    @Published var colorModel: ColorModel

    init() {
        // Initialize with a default color
        self.colorModel = ColorModel(selectedColor: .black)
    }

    // Additional logic can be added here
    func updateColor(to newColor: Color) {
        colorModel.selectedColor = newColor
    }
}
