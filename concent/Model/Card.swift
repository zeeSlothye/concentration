//
//  Card.swift
//  concent
//
//  Created by 김승예 on 2021/06/06.
//

import Foundation
struct Card{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
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
