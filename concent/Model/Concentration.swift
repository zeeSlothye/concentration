//
//  Concentration.swift
//  concent
//
//  Created by 김승예 on 2021/06/06.
//

import Foundation
class Concentration{
    var cards = [Card]()
    
    //card pair의 수를 받아와 카드 생성 후 array에 대입
    init (numberOfPairsOfCards:Int){
        for _ in 0...numberOfPairsOfCards-1{
            let card = Card()
            cards += [card,card]
        }
        //cards의 배열 순서를 무작위로 바꾼다.
        shuffle()

    }
    
    func shuffle(){
        for _ in 0...cards.count{
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards += [cards.remove(at: randomIndex)]
        }
    }
    
    var indexOfOneAndOnlyFaceUpCard:Int?
    
    //toggle isFaceUP
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //matched
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{ //no face, two face
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
