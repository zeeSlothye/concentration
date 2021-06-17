//
//  ViewController.swift
//  concent
//
//  Created by 김승예 on 2021/06/06.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int{
        return (cardButtons.count+1)/2
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    var flipCount: Int = 0{
        didSet{
            flipCountLabel.text = "Flip Card: \(flipCount)"
        }
    }
    
    
    @IBOutlet var cardButtons: [UIButton]!

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        
        if let cardNumber = cardButtons.firstIndex(of:sender){
            game.chooseCard(at: cardNumber) //control isFaceup
            updateViewFromModel()
        }else{
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel(){
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
    
    lazy var emojiSet:[[String]] = [emojiChoices0, emojiChoices1,emojiChoices2,emojiChoices3,emojiChoices4,emojiChoices5]
    var emojiChoices0: Array<String> = ["👻", "🎃", "🍭","🍫","🍩","🍪","🍬", "👠","🧛🏿‍♂️","🧟‍♀️"]
    var emojiChoices1: Array<String> = ["😍","🤪","🥸","😎","😡","🥶","🤢","👿","😶‍🌫️","🤯","🤬"]
    var emojiChoices2: Array<String> = ["🍏","🍎","🍊","🍋","🍉","🍇","🍓","🫐","🍒","🍑","🌰","🍌"]
    var emojiChoices3: Array<String> = ["🥭","🥝","🍅","🍆","🥦","🥬","🌶","🌽","🫑","🍠","🥔","🍳","🥩"]
    var emojiChoices4: Array<String> = ["❤️","🧡","💛","💚","💙","💜","🖤","🤍","🤎","💖","💔","👩‍❤️‍👨","👩🏼‍❤️‍💋‍👩🏿","👅"]
    var emojiChoices5: Array<String> = ["⚽️","🏀","🏈","🥎","🏉","🥏","🏓","🪀","🏏","🥊","🛼","🏵","🎟","🎖","🚵‍♀️"]

    
    var emoji = [Int:String]()

    func emoji(for card:Card, at emojiIndex:Int)-> String{
        print("beforecount: \(emojiSet[emojiIndex].count)")
        if emoji[card.identifier] == nil, emojiSet[emojiIndex].count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiSet[emojiIndex].count)))
            print("hi: \(emoji[card.identifier]), count: \(emojiSet[emojiIndex].count)")
            emoji[card.identifier] = emojiSet[emojiIndex].remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    var emojiIndex = 0
    
    //start new game
    @IBAction func newGame(_ sender: UIButton) {
        flipCount = 0
        reset()
        emojiIndex = Int(arc4random_uniform(UInt32(emojiSet.count)))
    }
    
    func reset(){
        //cardButton들의 isFaceUp, isMatched를 모두 false로 만든다.
        for card in cardButtons.indices{
            game.cards[card].isFaceUp = false
            game.cards[card].isMatched = false
            emoji[game.cards[card].identifier] = nil
        }
        updateViewFromModel() //reset card state
        game.shuffle()//shuffle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

