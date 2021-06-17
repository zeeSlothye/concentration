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
    
    static var identifierFactory:Int = 0
    static func getUniqueIdentifier()->Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
