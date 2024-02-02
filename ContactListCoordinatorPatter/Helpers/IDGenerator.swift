//
//  IDGenerator.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import Foundation
//an IDGenerator Generic Protocol whose associate type is the type of ID

protocol IDGenerator {
    associatedtype ID
    
    func generateID() -> ID
}

class LinearIntegerIDGenerator: IDGenerator {
    typealias ID = Int
    
    private var nextID: Int = 0
    
    func generateID() -> Int {
        nextID += 1
        return nextID
    }

    func generateID(withSeed seed: Int) -> Int {
        nextID += seed
        return nextID
    }
}
