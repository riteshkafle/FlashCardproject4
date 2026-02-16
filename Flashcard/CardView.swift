//
//  CardView.swift
//  Flashcard
//
//  Created by Ritesh Kafle on 2/10/26.
//

import SwiftUI

struct CardView: View {

    let card: Card

    var onSwipedLeft: (() -> Void)?
    var onSwipedRight: (() -> Void)?

    @State private var isShowingQuestion = true
    @State private var offset: CGSize = .zero

    private let swipeThreshold: Double = 200

    var body: some View {
        ZStack {

            ZStack {

                RoundedRectangle(cornerRadius: 25.0)
                    .fill(offset.width < 0 ? .red : .green)

                RoundedRectangle(cornerRadius: 25.0)
                    .fill(isShowingQuestion ? Color.blue.gradient : Color.indigo.gradient)
                    .shadow(color: .black, radius: 4, x: -2, y: 2)
                    .opacity(1 - abs(offset.width) / swipeThreshold)
            }

            VStack(spacing: 20) {

                Text(isShowingQuestion ? "Question" : "Answer")
                    .bold()

                Rectangle()
                    .frame(height: 1)

                Text(isShowingQuestion ? card.question : card.answer)
            }
            .font(.title)
            .foregroundStyle(.white)
            .padding()
        }
        .frame(width: 300, height: 500)
        .opacity(3 - abs(offset.width) / swipeThreshold * 3)
        .rotationEffect(.degrees(offset.width / 20.0))
        .offset(CGSize(width: offset.width, height: 0))
        .onTapGesture {
            isShowingQuestion.toggle()
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { gesture in
                    if gesture.translation.width > swipeThreshold {
                        onSwipedRight?()
                    } else if gesture.translation.width < -swipeThreshold {
                        onSwipedLeft?()
                    } else {
                        withAnimation(.bouncy) {
                            offset = .zero
                        }
                    }
                }
        )
    }
}

#Preview {
    CardView(
        card: Card(
            question: "Capital of USA?",
            answer: "DC"
        ),
        onSwipedLeft: { print("Swiped left") },
        onSwipedRight: { print("Swiped right") }
    )
}
