//
//  CoustomFontsView.swift
//  SimplyTestApp
//
//  Created by Iqbal Sheikh on 31/12/24.
//

import SwiftUI


struct CustomFontsView: View {
    @Environment(\.dismiss) var dismiss // Dismiss action
    @EnvironmentObject var viewModel: FontsViewModel // Shared ViewModel
    
    var body: some View {
        VStack {
            // Close button
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.gray)
                        .padding(6)
                }
                Spacer()
            }
            
            // Font Selection
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.fonts, id: \.self) { font in
                        Text(font)
                            .font(.headline)
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.black)
                            )
                            .background(viewModel.selectedFont == font ? Color.blue.opacity(0.3) : Color.clear)
                            .cornerRadius(16)
                            .onTapGesture {
                                viewModel.selectedFont = font
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }
}

struct CustomFontsView_Previews: PreviewProvider {
    static var previews: some View {
        CustomFontsView()
            .environmentObject(FontsViewModel()) // Provide a mock ViewModel
    }
}

