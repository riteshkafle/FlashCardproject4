//
//  Card.swift
//  Flashcard
//
//  Created by Ritesh Kafle on 2/10/26.
//

import Foundation


struct Card: Equatable {
    let question: String
    let answer: String

    static let mockedCards: [Card] = [
        Card(question: "Located at the southern end of Puget Sound, what is the capitol of Washington?", answer: "Olympia"),
        Card(question: "Capital of Texas?", answer: "Austin"),
        Card(question: "Best Food in DC?", answer: "CafeDC"),
        Card(question: "President of USA?", answer: "Trumph"),
        Card(question: "In which State is Howard University?", answer: "D.C")
    ]
}
