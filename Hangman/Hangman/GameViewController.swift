//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Properties
    @IBOutlet weak var wordToGuess: UILabel!
    @IBOutlet weak var letterGuessed: UITextField!
    @IBOutlet weak var wordBank: UILabel!
    @IBOutlet weak var hangManPic: UIImageView!
    
    var mainPhrase = ""
    var blankedPhrase = ""
    var correctLetters: [String] = []
    var incorrectLetters: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        letterGuessed.delegate = self

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        mainPhrase = phrase!
        wordToGuess.text = phrase
        var pleaseWork = ""
        
        for i in (phrase?.characters)! {
            if i == " " {
                pleaseWork += "  "
            } else {
                pleaseWork += "_ "
            }
        }
        print(pleaseWork)
        print(mainPhrase)
        wordToGuess.text = pleaseWork
        blankedPhrase = pleaseWork
        hangManPic.image = #imageLiteral(resourceName: "hangman1.gif")
        correctLetters = []
        incorrectLetters = []
//        hangManPic.image = hangman1.gif
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool
    {
        let maxLength = 1
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }

    
    //MARK: Actions
    @IBAction func guessButton(_ sender: UIButton) {
        var currBlankedPhrase = ""
        for letter in mainPhrase.characters {
            if self.correctLetters.contains(String(letter).lowercased()) {
                currBlankedPhrase += String(letter).lowercased()
            } else if String(letter).lowercased() == letterGuessed.text! {
                self.correctLetters.append(letterGuessed.text!)
                currBlankedPhrase += letterGuessed.text!
            } else if String(letter) == " "{
                currBlankedPhrase += "  "
            } else {
                currBlankedPhrase += "_ "
            }
        }
        var lettersInBank = ""
        if currBlankedPhrase == blankedPhrase && !incorrectLetters.contains(letterGuessed.text!) && !correctLetters.contains(letterGuessed.text!){
            incorrectLetters.append(letterGuessed.text!)
        }
        
        for letter in incorrectLetters {
            lettersInBank += letter + " "
        }
        
        if incorrectLetters.count == 1 {
            hangManPic.image = #imageLiteral(resourceName: "hangman2.gif")
        } else if incorrectLetters.count == 2 {
            hangManPic.image = #imageLiteral(resourceName: "hangman3.gif")
        } else if incorrectLetters.count == 3 {
            hangManPic.image = #imageLiteral(resourceName: "hangman4.gif")
        } else if incorrectLetters.count == 4 {
            hangManPic.image = #imageLiteral(resourceName: "hangman5.gif")
        } else if incorrectLetters.count == 5 {
            hangManPic.image = #imageLiteral(resourceName: "hangman6.gif")
        } else if incorrectLetters.count == 6 {
            hangManPic.image = #imageLiteral(resourceName: "hangman7.gif")
            let alert = UIAlertController(title: "Alert", message: "LOSER", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "New Game?", style: UIAlertActionStyle.default, handler:restart))
            self.present(alert, animated: true, completion: nil)
        }
        
        if !currBlankedPhrase.contains("_") {
            let alert = UIAlertController(title: "Alert", message: "WINNER", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "New Game?", style: UIAlertActionStyle.default, handler:restart))
            self.present(alert, animated: true, completion: nil)
        }
        
        wordBank.text = lettersInBank
        blankedPhrase = currBlankedPhrase
        wordToGuess.text = currBlankedPhrase
    }
    
    func restart(actionTarge: UIAlertAction) {
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        mainPhrase = phrase!
        wordToGuess.text = phrase
        var pleaseWork = ""
        
        for i in (phrase?.characters)! {
            if i == " " {
                pleaseWork += "  "
            } else {
                pleaseWork += "_ "
            }
        }
        print(pleaseWork)
        print(mainPhrase)
        wordToGuess.text = pleaseWork
        blankedPhrase = pleaseWork
        hangManPic.image = #imageLiteral(resourceName: "hangman1.gif")
        correctLetters = []
        incorrectLetters = []
        wordBank.text = ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
