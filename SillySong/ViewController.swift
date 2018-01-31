//
//  ViewController.swift
//  SillySong
//
//  Created by Jeffrey Pape on 18-1-30.
//  Copyright © 2018 Pape Software. All rights reserved.
//

import UIKit

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        self.nameField.autocapitalizationType = .words
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reset(_ sender: AnyObject) {
        print("reset begin")
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: AnyObject) {
        if nameField.text != "" {
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
        }
    }
    
}

func shortNameFromName(name: String) -> String {
    let lowercaseName = name.lowercased().folding(options: .diacriticInsensitive, locale: .current)
    let vowelSet = CharacterSet(charactersIn: "AEIOUaeiou")
    
    if let firstVowelRange = name.rangeOfCharacter(from: vowelSet, options: .caseInsensitive) {
        return String(lowercaseName[firstVowelRange.lowerBound...])
    }
    
    // no vowels = return the full name
    return lowercaseName
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

