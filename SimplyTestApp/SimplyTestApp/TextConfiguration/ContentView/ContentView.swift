//  ContentView.swift
//  ContentView
//
//  Created by Iqbal Sheikh on 28/12/24.

import SwiftUI

import PhotosUI


struct ContentView: View {
    @StateObject private var fontsViewModel = FontsViewModel() // Create FontsViewModel instance
    @StateObject private var colorPickerViewModel = ColorPickerViewModel() // Create ViewModel instance

    //    // State variables to manage UI behavior and user interactions
    @State private var selectedImage: UIImage? = nil // Holds the selected background image
    @State private var isImagePickerPresented: Bool = false // Controls the visibility of the image picker
    @State private var isTextEditorPresented: Bool = false // Controls the visibility of the text editor sheet
    @State private var enteredText: String = "" // Stores the user-entered text
    @State private var inflection: CGFloat = 0.0 // Controls the curvature of the text
    @State private var isTextSelected: Bool = false // Tracks whether the text is selected
    
    // Gesture-related state variables
    @State private var textPosition: CGSize = .zero // Tracks the position of the text
    @State private var textScale: CGFloat = 1.0 // Tracks the scale of the text
    @State private var textRotation: Angle = .zero // Tracks the rotation of the text
    @State private var selectedFont: String = "Arial" // Tracks the selected font
    
    var body: some View {
        // Layout for the UI
        AddTextButton
        
        // Slider to adjust text curvature
        SliderView(inflection: $inflection)
        
        VStack {
            // Display the background image with the text mask
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .mask(
                        CurvedTextView(
                            inflection: $inflection,
                            selectedFont: $fontsViewModel.selectedFont,
                            selectedImage: selectedImage ?? UIImage(),
                            enteredText: $enteredText,
                            selectedColor: $colorPickerViewModel.colorModel.selectedColor
                        )
                    )
                    .rotationEffect(textRotation)
                    .offset(textPosition)
                    .scaleEffect(textScale)
                    .gesture(
                        applyGestures()
                    )
                    .onTapGesture {
                        // Toggle text selection state
                        print("Text tapped!")
                        self.isTextSelected.toggle()
                    }
            } else {
                // Default view with the curved text editor
                CurvedTextView(
                    inflection: $inflection,
                    selectedFont: $fontsViewModel.selectedFont,
                    selectedImage: selectedImage ?? UIImage(),
                    enteredText: $enteredText,
                    selectedColor: $colorPickerViewModel.colorModel.selectedColor
                )

                .rotationEffect(textRotation)
                .offset(textPosition)
                .scaleEffect(textScale)
                
                .gesture(
                    applyGestures()
                )
                .onTapGesture {
                    // Toggle text selection state
                    print("Text tapped!")
                    self.isTextSelected.toggle()
                }
                
            }
        }
        
        PickImageButton
        // Sheet to present the image picker
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(selectedImage: $selectedImage)
        }
        // Sheet to present the text editor
        .sheet(isPresented: $isTextEditorPresented) {
            TextEditorSheetView(
                       enteredText: $enteredText,
                       isPresented: $isTextEditorPresented,
                       selectedFont: $fontsViewModel.selectedFont, colorPickerViewModel: colorPickerViewModel
            )
            .environmentObject(fontsViewModel)
            .environmentObject(colorPickerViewModel) // Pass the colorPickerViewModel

        }
    }
    
    
    private var PickImageButton: some View {
        VStack {
            Spacer()
            Button("Pick an Image") {
                // Opens the image picker sheet
                isImagePickerPresented = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
    
    private var AddTextButton: some View {
        HStack {
            Spacer()
            Button(action: {
                // Opens the text editor sheet
                isTextEditorPresented = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.blue)
            }
            .padding(.trailing, 20)
        }
    }
    
    private func applyGestures() -> some Gesture {
        DragGesture()
            .onChanged { value in
                self.textPosition = value.translation
            }
            .simultaneously(with: RotationGesture()
                .onChanged { angle in
                    self.textRotation = angle
                }
            )
            .simultaneously(with: MagnificationGesture()
                .onChanged { scaleValue in
                    self.textScale = scaleValue
                }
            )
    }
}

#Preview {
    ContentView()
}





