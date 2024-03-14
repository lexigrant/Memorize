//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Lexi Grant on 1/18/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
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
            Button("Shuffle") {
                viewModel.shuffle()
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
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
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
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
    }
}










struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
