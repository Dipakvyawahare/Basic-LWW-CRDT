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
