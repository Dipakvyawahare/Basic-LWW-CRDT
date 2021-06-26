//
//  LWWSet.swift
//  CloudNotes
//
//  Created by Dipak V. Vyawahare on 26/06/21.
//

import Foundation

///(Last-Write-Wins)LWW-element-set class from CRDT

class LWWSet<T: Equatable> {
    private var elements = [Element<T>]()
    private let queue = DispatchQueue(label: "com.lwwset",
                                      attributes: .concurrent)
    private var safeElements: [Element<T>] {
        var values: [Element<T>]?
        queue.sync { [unowned self] in
            values = self.elements
        }
        return values ?? []
    }

    func add(_ value: T) {
        append(value, operation: .add)
    }

    private func append(_ value: T,
                        operation: Element<T>.Operation) {
        queue.async(flags: .barrier) { [unowned self] in
            elements.append(.init(value: value,
                                  operation: operation))
        }
    }

    func remove(_ value: T) {
        if exist(value) {
            append(value, operation: .remove)
        }
    }

    func values() -> [T] {
        var result = [T]()
        for element in self.safeElements {
            switch element.operation {
            case .add:
                result.append(element.value)
            case .remove:
                result.removeAll(where: {$0 == element.value})
            }
        }
        return result
    }

    func exist(_ value: T) -> Bool {
        guard let element = safeElements.last(where: {$0.value == value}) else {
            return false
        }
        return element.operation == .add
    }

    func merge(_ set: LWWSet<T>) -> LWWSet<T> {
        let mergedSet = LWWSet<T>()
        mergedSet.elements.append(contentsOf: self.safeElements)
        mergedSet.elements.append(contentsOf: set.safeElements)
        mergedSet.elements.sort()
        return mergedSet
    }
}
