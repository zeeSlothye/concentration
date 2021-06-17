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
    
    var indexOfOneAndOnlyFaceUpCard:Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices{
                //해당 카드가 앞면일 경우, 앞면인 카드를 찾게됨.
                if cards[index].isFaceUp {
                    //앞면인
                    if foundIndex == nil {
                        foundIndex = index
                    }//앞면인 카드를 한번 더 찾는다. => only one이 앞면이 아니므로 return nil
                    else{
                        return nil
                    }
                }
            }
            return foundIndex
        }
        //모든 카드를 살펴본 후 newValue에 대한 카드를 제외하고 전부 뒤집는다.
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue) //index가 newVaue와 같을때만 true
            }
        }
    }
    
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
// index를 computed로               indexOfOneAndOnlyFaceUpCard = nil
            }else{ //no face, two face
//                for flipDownIndex in cards.indices{
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
