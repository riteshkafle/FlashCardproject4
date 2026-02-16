//
//  CreateFlashCardView.swift
//  Flashcard
//
//  Created by Ritesh Kafle on 2/10/26.
//

import SwiftUI

struct CreateFlashcardView: View {

    var onCreate: (Card) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var questionText = ""
    @State private var answerText = ""

    var body: some View {
        VStack(spacing: 60) {

            HStack {
                Spacer()

                Button("Save") {
                    onCreate(Card(question: questionText, answer: answerText))
                    dismiss()
                }
                .disabled(questionText.isEmpty || answerText.isEmpty)
            }

            VStack(spacing: 20) {
                TextField("Add a question...", text: $questionText, axis: .vertical)
                TextField("Add an answer...", text: $answerText, axis: .vertical)
            }
            .textFieldStyle(.roundedBorder)
            .font(.title)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    CreateFlashcardView { card in
        print("New card created: \(card)")
    }
}
