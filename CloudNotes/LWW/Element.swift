//
//  Element.swift
//  CloudNotes
//
//  Created by Dipak V. Vyawahare on 26/06/21.
//

import Foundation

///Element to store into Set
struct Element<T: Equatable> {
    enum Operation {
        case add
        case remove
    }

    let timestamp = Date()
    let value: T
    let operation: Operation
}

///Sort based on timestamp
extension Element: Comparable {
    static func < (lhs: Element<T>,
                   rhs: Element<T>) -> Bool {
        lhs.timestamp.compare(rhs.timestamp) == .orderedAscending
    }
}
