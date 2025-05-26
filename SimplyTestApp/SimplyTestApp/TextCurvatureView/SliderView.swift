//
//  SliderView.swift
//  SimplyTestApp
//
//  Created by Iqbal Sheikh on 30/12/24.
//

import SwiftUI

struct SliderView: View {
    @Binding var inflection: CGFloat

    var body: some View {
        SliderView
    }
    private var SliderView: some View{
        VStack {
            Text("Curvature (Inflection)")
                .font(.headline)
            
            Slider(value: $inflection, in: -1...1, step: 0.2)
                .padding()
            
            Text(String(format: "Inflection: %.3f", inflection))
        }
    }
}

//#Preview {
//    SliderView(inflection: $inflection)
//}
