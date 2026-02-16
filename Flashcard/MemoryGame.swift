//
//  MemoryGame.swift
//  Flashcard
//
//  Created by Ritesh Kafle on 2/10/26.
//

import Foundation

struct MemoryCard: Identifiable, Equatable {
    let id: UUID
    let value: String

    init(id: UUID = UUID(), value: String) {
        self.id = id
        self.value = value
    }
}

enum MemoryGamePairCount: Int, CaseIterable {
    case four = 4
    case six = 6
    case eight = 8
    case fourteen = 14
    case twenty = 20

    var displayName: String { "\(rawValue) pairs" }
}

struct MemoryGameDeck {
    private static let symbols: [String] = [
        "🎴", "🃏", "🌟", "❤️", "🔥", "⭐️", "🌈", "🎯",
        "🍀", "🎲", "🎭", "🎪", "🚀", "💎", "🎸", "🎺",
        "🎨", "🏆", "🎁", "🌺"
    ]

    static func makeCards(pairCount: Int) -> [MemoryCard] {
        let count = min(pairCount, symbols.count)
        let chosen = Array(symbols.prefix(count))
        var cards: [MemoryCard] = []
        for value in chosen {
            cards.append(MemoryCard(value: value))
            cards.append(MemoryCard(value: value))
        }
        return cards.shuffled()
    }
}
