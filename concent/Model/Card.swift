//
//  Card.swift
//  concent
//
//  Created by 김승예 on 2021/06/06.
//


struct Card: Hashable{
    //make struct hashable
    var hashValue: Int { return identifier }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    var flippedCount = 0
    
    private static var identifierFactory:Int = 0
    private static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
