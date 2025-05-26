
//
//  ColorPickerView.swift
//  ColorPickerView
//
//  Created by Iqbal Sheikh on 04/01/25.
//
import SwiftUI


struct ColorPickerView: View {
    @ObservedObject var colorPickerViewModel: ColorPickerViewModel
    var body: some View {
        VStack {
            // ColorPicker bound to the ViewModel's selected color
            ColorPicker("Pick a Font color", selection: $colorPickerViewModel.colorModel.selectedColor)
                .padding()

        }
        .padding()
    }
}
#Preview {
    ColorPickerView(colorPickerViewModel: ColorPickerViewModel())
}
