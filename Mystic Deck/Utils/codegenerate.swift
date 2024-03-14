//
//  codegenerate.swift
//  Mystic Deck
//
//  Created by user1 on 25/02/24.
//

import Foundation
func generateUniqueCode() -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    var code = ""
    
    // Generate a 6-letter combination code
    for _ in 0..<6 {
        let randomIndex = Int.random(in: 0..<letters.count)
        let randomCharacter = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
        code.append(randomCharacter)
    }
    
    return code
}
