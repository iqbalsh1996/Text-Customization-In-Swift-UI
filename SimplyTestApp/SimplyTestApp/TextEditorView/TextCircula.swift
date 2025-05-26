//
//  TextCircula.swift
//  SimplyTestApp
//
//  Created by Iqbal Sheikh on 09/01/25.
//


import SwiftUI

struct TextCircula: View {
    @State private var angle: Double = 0
    let text = "360° Arc of Text"

    var body: some View {
            VStack {
                Slider(value: $angle, in: 0...360, step: 1)
                    .padding()

                GeometryReader { geometry in
                    ZStack {
                        ForEach(0..<text.count, id: \.self) { index in
                            Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                                .font(.title)
                                .position(
                                    x: geometry.size.width / 2 + cos(CGFloat(angle + (Double(index) * 360 / Double(text.count)))) * 150,
                                    y: geometry.size.height / 2 + sin(CGFloat(angle + (Double(index) * 360 / Double(text.count)))) * 150
                                )
                                .rotationEffect(.degrees(Double(index) * -360 / Double(text.count)))
                        }
                    }
                    .frame(width: 300, height: 300)
                }
                .frame(width: 300, height: 300)
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TextCircula()
    }
}
