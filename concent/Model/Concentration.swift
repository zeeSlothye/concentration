//
//  Concentration.swift
//  concent
//
//  Created by 김승예 on 2021/06/06.
//

import Foundation
struct Concentration{
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
    
    private mutating func shuffle(){
        for _ in 0...cards.count{
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards += [cards.remove(at: randomIndex)]
        }
    }
    
    private var indexOfOneAndOnlyFaceUpCard:Int? {
        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnly
//            let faceUpCardIndices = cards.indices.filter {cards[$0].isFaceUp} //isFaceUp이 true인 index의 배열.
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }

        //모든 카드를 살펴본 후 newValue에 대한 카드를 제외하고 전부 뒤집는다.
        set{
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue) //index가 newVaue와 같을때만 true
            }
        }
    }
    
    //toggle isFaceUP
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard (at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched{
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //matched
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            }else{ //no face, two face
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
}

extension Collection {
    var oneAndOnly: Element?{
        return count == 1 ? first: nil //count, first는 collection의 method이므로 property를 구현할 떄 사용 할 수 있다.
    }
}
