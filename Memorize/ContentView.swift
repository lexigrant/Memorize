//
//  ContentView.swift
//  Memorize
//
//  Created by Lexi Grant on 1/18/24.
//

import SwiftUI

struct ContentView: View {
    let christmas: [String] = ["🎄", "🎅🏽", "🎁", "🍪", "🥛", "❄️", "⛄️", "🦌", "🪄", "🦉", "🎄", "🎅🏽", "🎁", "🍪", "🥛", "❄️", "⛄️", "🦌", "🪄", "🦉"]
    let animals: [String] = ["🐶", "🐱", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🐶", "🐱", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯"]
    let halloween: [String] = ["👻", "💀", "🎃", "🕷️", "😈", "🕸️", "🧙🏽‍♀️", "🐈‍⬛", "👹", "😱", "☠️", "🍭","👻", "💀", "🎃", "🕷️", "😈", "🕸️", "🧙🏽‍♀️", "🐈‍⬛", "👹", "😱", "☠️", "🍭"]
    @State var emojis: [String] = ["👻", "💀", "🎃", "🕷️", "😈", "🕸️", "🧙🏽‍♀️", "🐈‍⬛", "👹", "😱", "☠️", "🍭", "👻", "💀", "🎃", "🕷️", "😈", "🕸️", "🧙🏽‍♀️", "🐈‍⬛", "👹", "😱", "☠️", "🍭"]
    @State var cardCount: Int = 4
    var body: some View {
        VStack {
            Text("Memorize")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
            Button(action: {
                emojis = animals.shuffled()
            }, label: {
                Image(systemName: "dog.fill")
                Text("Animals").font(.subheadline)
            })
            Button(action: {
                emojis = christmas.shuffled()
            }, label: {
                Image(systemName: "snowflake")
                Text("Christmas").font(.subheadline)
            })
            Button(action: {
                emojis = halloween.shuffled()
            }, label: {
                Image(systemName: "ant.circle.fill")
                Text("Halloween").font(.subheadline)
            })
        }
        .padding()
    }
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    var cardAdder: some View {
        return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    var body: some View {
        ZStack {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}






























#Preview {
    ContentView()
}
