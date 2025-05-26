//
//  FontsViewModel.swift
//  SimplyTestApp
//
//  Created by Iqbal Sheikh on 04/01/25.
//

import Foundation
import SwiftUI

class FontsViewModel: ObservableObject {
    // List of available fonts
    let fonts = [
        "Arial", "Helvetica", "Courier New", "Georgia", "Times New Roman",
        "Verdana", "Palatino", "Avenir", "Avenir Next", "Chalkduster",
        "Futura", "Gill Sans", "Trebuchet MS", "Zapfino", "Baskerville",
        "Didot", "Optima", "American Typewriter", "Menlo"
    ]
    
    // Selected font
    @Published var selectedFont: String = "Arial" // Default font
}
