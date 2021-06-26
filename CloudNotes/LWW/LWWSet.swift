//
//  LWWSet.swift
//  CloudNotes
//
//  Created by Dipak V. Vyawahare on 26/06/21.
//

import Foundation

///(Last-Write-Wins)LWW-element-set class from CRDT

class LWWSet<T: Equatable> {
    // MARK: - Private scope
    private var elements = [Element<T>]()

    ///To maintain thread safety using private concurrent queue
    private let queue = DispatchQueue(label: "com.lwwset",
                                      attributes: .concurrent)

    private var sortedElements: [Element<T>] {
        var values: [Element<T>]?
        queue.sync { [unowned self] in
            values = self.elements
        }
        return values?.sorted() ?? []
    }

    private func append(_ value: T,
                        operation: Element<T>.Operation) {
        queue.async(flags: .barrier) { [unowned self] in
            elements.append(.init(value: value,
                                  operation: operation))
        }
    }

    // MARK: - Public scope

    ///This method adds the element into the set
    func add(_ value: T) {
        append(value, operation: .add)
    }

    ///This method removes the element from the LWW
    func remove(_ value: T) {
        if exist(value) {
            append(value, operation: .remove)
        }
    }

    ///Fetch all the available values
    ///Ignoring deleted values
    func values() -> [T] {
        var result = [T]()
        for element in self.sortedElements {
            switch element.operation {
            case .add:
                result.append(element.value)
            case .remove:
                if let index = result.lastIndex(of: element.value) {
                    result.remove(at: index)
                }
            }
        }
        return result
    }

    /// This method check whether a given element is in LWW
    func exist(_ value: T) -> Bool {
        guard let element = sortedElements.last(where: {$0.value == value}) else {
            return false
        }
        return element.operation == .add
    }

    ///This method merge the LWW with the given LWW and returns a new LWW
    func merge(_ set: LWWSet<T>) -> LWWSet<T> {
        let mergedSet = LWWSet<T>()
        mergedSet.elements.append(contentsOf: self.sortedElements)
        mergedSet.elements.append(contentsOf: set.sortedElements)
        mergedSet.elements.sort()
        return mergedSet
    }
}
