//
//  ContentView.swift
//  Memorize
//
//  Created by Lexi Grant on 1/18/24.
//

import SwiftUI

struct ContentView: View {
    let emojis: [String] = ["👻", "💀", "🎃", "🕷️", "😈"]
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                    base.foregroundColor(.white)
                    base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            } else {
                base.fill()
            }
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}






























#Preview {
    ContentView()
}
