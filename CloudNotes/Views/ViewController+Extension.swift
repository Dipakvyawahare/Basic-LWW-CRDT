//
//  ViewController+Extension.swift
//  CloudNotes
//
//  Created by Dipak V. Vyawahare on 13/07/21.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        makeEntry(text,
                  range: range,
                  string: string)
        mergedLabel.text = String(lwwSet.values().map({$0.character}))
        return true
    }

    private func makeEntry(_ text: String,
                      range: NSRange,
                      string: String) {
        if string.isEmpty { //On backspace
            if let deleted = text[range.lowerBound..<range.upperBound].first {
                let node = Node(location: range.location,
                                character: deleted)
                lwwSet.remove(node)
            }

        } else {
            if let firstChar = string.first {
                let node = Node(location: range.location,
                                character: firstChar)
                lwwSet.add(node)
            }
        }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let merged = String(lwwSet.values().map({$0.character}))
        textField1.text = merged
        textField2.text = merged
        return true
    }
}
