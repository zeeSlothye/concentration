//
//  ViewController.swift
//  concent
//
//  Created by 김승예 on 2021/06/06.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    private var numberOfPairsOfCards: Int{
        return (cardButtons.count+1)/2
    }
    
    
    private(set) var flipCount: Int = 0{
        didSet{
            flipCountLabel.text = "Flip: \(flipCount)"
        }
    }
    
    private var currentScore: Int = 0{
        didSet{
            score.text = "Score: \(currentScore)"
        }
    }


    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var score: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!

    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of:sender){
            game.chooseCard(at: cardNumber) //control isFaceup
            scoring(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card was not in cardButtons")
        }
    }
    
    private func scoring(at cardNumber: Int){
        game.cards[cardNumber].flippedCount += 1
        if game.cards[cardNumber].isMatched == true{ // add score if it is matched
            self.currentScore += 2
        }else if game.cards[cardNumber].flippedCount >= 2{
            self.currentScore -= 1
        }
    }

    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp { //toggle isFaceUP
                button.setTitle(emoji(for: card, at:emojiIndex), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor=card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) //card matched -> disappear
            }
        }
    }
    
    private lazy var emojiSet:[[String]] = [emojiChoices0, emojiChoices1,emojiChoices2,emojiChoices3,emojiChoices4,emojiChoices5]
    private  var emojiChoices0: Array<String> = ["👻", "🎃", "🍭","🍫","🍩","🍪","🍬", "👠","🧛🏿‍♂️","🧟‍♀️"]
    private var emojiChoices1: Array<String> = ["😍","🤪","🥸","😎","😡","🥶","🤢","👿","😶‍🌫️","🤯","🤬"]
    private var emojiChoices2: Array<String> = ["🍏","🍎","🍊","🍋","🍉","🍇","🍓","🫐","🍒","🍑","🌰","🍌"]
    private var emojiChoices3: Array<String> = ["🥭","🥝","🍅","🍆","🥦","🥬","🌶","🌽","🫑","🍠","🥔","🍳","🥩"]
    private var emojiChoices4: Array<String> = ["❤️","🧡","💛","💚","💙","💜","🖤","🤍","🤎","💖","💔","👩‍❤️‍👨","👩🏼‍❤️‍💋‍👩🏿","👅"]
    private var emojiChoices5: Array<String> = ["⚽️","🏀","🏈","🥎","🏉","🥏","🏓","🪀","🏏","🥊","🛼","🏵","🎟","🎖","🚵‍♀️"]

    
    private var emoji = [Int:String]()

    private func emoji(for card:Card, at emojiIndex:Int)-> String{
        if emoji[card.identifier] == nil, emojiSet[emojiIndex].count > 0{
            emoji[card.identifier] = emojiSet[emojiIndex].remove(at: emojiSet[emojiIndex].count.arc4random)
        }
        return emoji[card.identifier] ?? "startNew"
    }
    
    
    private var emojiIndex = 0
    
    //start new game
    @IBAction private func newGame(_ sender: UIButton) {
        flipCount = 0
        reset()
        emojiIndex = Int(arc4random_uniform(UInt32(emojiSet.count)))
    }
    
    private func reset(){
        //cardButton들의 isFaceUp, isMatched를 모두 false로 만든다.
        for card in cardButtons.indices{
            game.cards[card].isFaceUp = false
            game.cards[card].isMatched = false
            emoji[game.cards[card].identifier] = nil
            game.cards[card].flippedCount = 0
        }
        updateViewFromModel() //reset card state 이걸 해줘야 new State누르면 카드가 다 뒤집힌 상태로 시작함.
        currentScore = 0
    }
    
}

extension Int {
    var arc4random:Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }else {
            return 0
        }
    }
}

