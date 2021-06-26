//
//  ViewController.swift
//  CloudNotes
//
//  Created by Dipak V. Vyawahare on 26/06/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var mergedLabel: UILabel!
    let lwwSet = LWWSet<Node>()
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let text = textField.text

        if string.isEmpty { //On backspace
            if let deleted = text?[range.lowerBound..<range.upperBound].first {
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

        mergedLabel.text = String(lwwSet.values().map({$0.character}))
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let merged = String(lwwSet.values().map({$0.character}))
        textField1.text = merged
        textField2.text = merged
        return true
    }
}
