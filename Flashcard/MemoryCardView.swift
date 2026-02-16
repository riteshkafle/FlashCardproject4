//
//  MemoryCardView.swift
//  Flashcard
//
//  Created by Ritesh Kafle on 2/10/26.
//
//

import SwiftUI

struct MemoryCardView: View {
    let card: MemoryCard
    let isFlipped: Bool
    let isMatched: Bool
    let onTap: () -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(
                    LinearGradient(
                        colors: [Color.blue, Color.blue.opacity(0.85)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .strokeBorder(.white.opacity(0.5), lineWidth: 2)
                )
                .overlay(
                    Image(systemName: "questionmark.circle.fill")
                        .font(.system(size: 42))
                        .foregroundStyle(.white.opacity(0.95))
                )
                .opacity(isFlipped ? 0 : 1)
                .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))

            RoundedRectangle(cornerRadius: 14)
                .fill(
                    LinearGradient(
                        colors: [Color(red: 0.95, green: 0.9, blue: 1.0),
                                 Color(red: 0.85, green: 0.8, blue: 0.95)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .strokeBorder(Color.purple.opacity(0.6), lineWidth: 2)
                )
                .overlay(
                    Text(card.value)
                        .font(.system(size: 52, weight: .bold))
                )
                .opacity(isFlipped ? 1 : 0)
                .rotation3DEffect(.degrees(isFlipped ? 0 : 180), axis: (x: 0, y: 1, z: 0))
        }
        .opacity(isMatched ? 0 : 1)
        .scaleEffect(isMatched ? 0.5 : 1)
        .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isMatched)
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: isFlipped)
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        MemoryCardView(
            card: MemoryCard(value: "🌟"),
            isFlipped: false,
            isMatched: false,
            onTap: {}
        )
        MemoryCardView(
            card: MemoryCard(value: "🌟"),
            isFlipped: true,
            isMatched: false,
            onTap: {}
        )
    }
    .padding()
    .frame(width: 100, height: 120)
}
