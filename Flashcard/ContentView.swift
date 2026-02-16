//
//  ContentView.swift
//  Flashcard
//  Created by Ritesh Kafle on 2/10/26.
//

import SwiftUI

struct ContentView: View {
    @State private var pairCount: MemoryGamePairCount = .four
    @State private var cards: [MemoryCard] = MemoryGameDeck.makeCards(pairCount: 4)
    @State private var selectedCardIds: [UUID] = []
    @State private var matchedCardIds: Set<UUID> = []
    @State private var isChecking = false

    private let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 140), spacing: 14)
    ]

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.15, green: 0.12, blue: 0.25),
                    Color(red: 0.25, green: 0.18, blue: 0.4)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Memory Match")
                    .font(.title.bold())
                    .foregroundStyle(.white)

                HStack {
                    Text("Pairs:")
                        .foregroundStyle(.white.opacity(0.9))
                    Picker("Pairs", selection: $pairCount) {
                        ForEach(MemoryGamePairCount.allCases, id: \.self) { option in
                            Text(option.displayName).tag(option)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.white)
                    .onChange(of: pairCount) { _, newValue in
                        resetGame(pairCount: newValue.rawValue)
                    }
                }
                .padding(.horizontal)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(cards) { card in
                            MemoryCardView(
                                card: card,
                                isFlipped: selectedCardIds.contains(card.id) || matchedCardIds.contains(card.id),
                                isMatched: matchedCardIds.contains(card.id),
                                onTap: { handleTap(card: card) }
                            )
                            .frame(height: 120)
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)

                // Reset button
                Button {
                    resetGame(pairCount: pairCount.rawValue)
                } label: {
                    Label("New Game", systemImage: "arrow.clockwise.circle.fill")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(Color.purple.gradient)
                        )
                }
                .padding(.bottom, 24)
            }
        }
    }

    private func handleTap(card: MemoryCard) {
        guard !isChecking else { return }
        if matchedCardIds.contains(card.id) { return }
        if selectedCardIds.contains(card.id) { return }

        if selectedCardIds.count == 2 {
            return
        }

        selectedCardIds.append(card.id)

        if selectedCardIds.count == 2 {
            let first = cards.first { $0.id == selectedCardIds[0] }!
            let second = cards.first { $0.id == selectedCardIds[1] }!
            if first.value == second.value {
                matchedCardIds.insert(first.id)
                matchedCardIds.insert(second.id)
                selectedCardIds.removeAll()
            } else {
                isChecking = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    selectedCardIds.removeAll()
                    isChecking = false
                }
            }
        }
    }

    private func resetGame(pairCount: Int) {
        cards = MemoryGameDeck.makeCards(pairCount: pairCount)
        selectedCardIds.removeAll()
        matchedCardIds.removeAll()
        isChecking = false
    }
}

#Preview {
    ContentView()
}
