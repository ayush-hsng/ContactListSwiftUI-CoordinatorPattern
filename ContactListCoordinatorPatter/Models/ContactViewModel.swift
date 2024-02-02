//
//  ContactViewModel.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import Foundation
import SwiftUI

enum ContactValidationError: Error {
    case invalidMobileNumber
    case invalidName
}

enum Gender: String, CaseIterable {
    case male
    case female
    case others
    case undisclosed
}

class ContactViewModel: Identifiable, ObservableObject {
    var id: UUID

    @Published var name: String
    @Published var gender: Gender
    @Published var isBlocked: Bool
    @Published var number: String

    init(id: UUID? = nil, name: String, gender: Gender? = nil, isBlocked: Bool = false, number: String = "") throws {
        guard !name.isEmpty else {
            throw ContactValidationError.invalidName
        }
        
        guard Self.isValidMobileNumber(number) else {
            throw ContactValidationError.invalidMobileNumber
        }
        
        self.id = id ?? UUID()
        self.name = name
        self.gender = gender ?? .undisclosed
        self.isBlocked = isBlocked
        self.number = number
    }

    convenience init(id: UUID? = nil, name: String, genderString: String, isBlocked: Bool = false, number: String = "") throws {
        try self.init(id: id, name: name, gender: Gender(rawValue: genderString), isBlocked: isBlocked, number: number)
    }

    // Edit the name and throw an error if it's empty
    func editName(_ newName: String) throws {
        guard !newName.isEmpty else {
            throw ContactValidationError.invalidName
        }
        name = newName
    }

    // Edit the number and throw an error if it's not valid
    func editNumber(_ newNumber: String) throws {
        guard Self.isValidMobileNumber(newNumber) else {
            throw ContactValidationError.invalidMobileNumber
        }
        number = newNumber
    }

    // Edit the gender using a string
    func editGender(_ newGenderString: String) {
        if let newGender = Gender(rawValue: newGenderString) {
            gender = newGender
        } else {
            gender = .undisclosed
        }
    }

    // Edit the gender using a Gender enum
    func editGender(_ newGender: Gender) {
        gender = newGender
    }

    private static func isValidMobileNumber(_ number: String) -> Bool {
        // Implement your validation logic here
        let mobileNumberRegex = "^\\d{10}$" // Assuming a 10-digit mobile number format
    
        let mobileNumberPredicate = NSPredicate(format: "SELF MATCHES %@", mobileNumberRegex)
        return mobileNumberPredicate.evaluate(with: number)
    }
}

