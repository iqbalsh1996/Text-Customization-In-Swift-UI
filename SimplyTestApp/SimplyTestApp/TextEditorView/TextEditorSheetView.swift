//
//  TextEditorSheetView.swift
//  SimplyTestApp
//
//  Created by Iqbal Sheikh on 29/12/24.
//

import SwiftUI

// View for editing text with additional options for font and image selection
struct TextEditorSheetView: View {
    @Binding var enteredText: String // Binds to the text entered in the TextEditor
    @Binding var isPresented: Bool // Controls the presentation of this view
    @Binding var selectedFont: String // Binds to the currently selected font

    @State private var isImagePickerPresented: Bool = false // Tracks if the image picker is presented
    @State private var isPresent = false // Tracks if the font selection sheet is presented
    @State private var selectedImage: UIImage? = nil // Holds the selected image from the image picker
    @EnvironmentObject private var fontsViewModel: FontsViewModel // Shared ViewModel
    @ObservedObject  var colorPickerViewModel: ColorPickerViewModel // ColorPicker ViewModel

    var body: some View {
        NavigationView {
            VStack {
                // TextEditor for user input
                TextEditor(text: $enteredText)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Expands to fill available space
                
                
                    .font(.custom(fontsViewModel.selectedFont, size: 24)) // Applies the selected font
                    .padding() // Adds padding around the editor
                    .background(Color.gray.opacity(0.2)) // Light gray background
                    .cornerRadius(8) // Rounded corners
                    .shadow(radius: 5) // Adds shadow for a lifted appearance
                    .foregroundColor(colorPickerViewModel.colorModel.selectedColor) // Apply selected color for text

                Spacer()
                
                ColorPickerView(colorPickerViewModel: colorPickerViewModel)

                    // Button to trigger font selection
                    Button("Change Font") {
                        isPresent.toggle() // Toggles the font selection sheet
                    }
              
                
                .padding() // Adds padding around the buttons
                .background(Color.blue) // Blue background for the button container
                .foregroundColor(.white) // White text color for buttons
                .cornerRadius(8) // Rounded corners for the button container
                .shadow(radius: 5) // Adds shadow for a lifted appearance
            }
            .padding() // Adds padding to the VStack
            .navigationTitle("Enter Text") // Sets the navigation bar title
            .toolbar {
                // Toolbar with a "Done" button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false // Dismiss the view
                        isPresent = false // Dismiss the font selection sheet
                    }
                }
            }
            // Sheet for font selection
            .sheet(isPresented: $isPresent) {
                CustomFontsView()
                    .environmentObject(fontsViewModel) // Pass ViewModel to the environment
                    .presentationDetents([.fraction(0.2)])
                Spacer()
            }
            // Sheet for the image picker
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage) // Passes the selected image binding to the image picker
            }
        }
    }
}

#Preview {
    ContentView() // Preview of the view in a ContentView container
}
