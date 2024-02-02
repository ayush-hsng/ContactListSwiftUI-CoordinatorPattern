//
//  ContactListViewModel.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import Foundation
import SwiftUI

class ContactListViewModel: ObservableObject {
    @Published var contacts: [ContactViewModel]

    // ID generator for ContactViewModelList
    private var idGenerator: any IDGenerator

    init(contacts: [ContactViewModel] = [], idGenerator: (any IDGenerator)? = nil) {
        self.contacts = contacts
        self.idGenerator = idGenerator ?? LinearIntegerIDGenerator()
    }

    func getContactsOrderedByName() -> [ContactViewModel] {
        return contacts.sorted { $0.name < $1.name }
    }

    @MainActor
    func createContact(id: UUID? = nil, name: String, number: String, gender: Gender? = nil, isBlocked: Bool = false) throws {
        let contact = try ContactViewModel(id: id, name: name, gender: gender ?? .undisclosed, isBlocked: isBlocked, number: number)
        contacts.append(contact)
    }

    func searchContactByID(_ contactID: UUID) -> ContactViewModel? {
        return contacts.first { $0.id == contactID }
    }

    func searchContactsByName(_ searchText: String) -> [ContactViewModel] {
        return contacts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    @MainActor
    func deleteContactByID(_ contactID: UUID) -> ContactViewModel? {
        if let index = contacts.firstIndex(where: { $0.id == contactID }) {
            let deletedContact = contacts.remove(at: index)
            return deletedContact
        }
        return nil
    }

    @MainActor
    func updateContactDetailsByID(_ contactID: UUID, newName: String? = nil, newGender: Gender? = nil, newIsBlocked: Bool? = nil, newNumber: String? = nil) throws {
        guard let contactIndex = contacts.firstIndex(where: { $0.id == contactID }) else {
            throw ContactValidationError.invalidMobileNumber
        }

        let currentContact = contacts[contactIndex]

        do {
            if let newName {
                try currentContact.editName(newName)
            }
            if let newNumber {
                try currentContact.editNumber(newNumber)
            }
        } catch {
            print("Error updating contact: \(error)")
        }
        
        let updatedContact = try ContactViewModel(
            id: currentContact.id,
            name: currentContact.name,
            gender: newGender ?? currentContact.gender,
            isBlocked: newIsBlocked ?? currentContact.isBlocked,
            number: currentContact.number
        )

        contacts[contactIndex] = updatedContact
    }
}

//// Example usage:
//let contactList = ContactListViewModel()
//
//do {
//    try contactList.createContact(name: "John Doe", number: "123-456-7890")
//    try contactList.createContact(name: "Jane Doe", number: "987-654-3210", gender: .female)
//    try contactList.createContact(name: "Alex Smith", number: "555-1234", gender: .male)
//} catch {
//    print("Error: \(error)")
//}
//
//print("Before update:")
//print(contactList.contacts)
//
//do {
//    try contactList.updateContactDetailsByID(contactList.contacts[1].id, newName: "Updated Jane", newGender: .male, newIsBlocked: true, newNumber: "111-222-3333")
//} catch {
//    print("Error updating contact: \(error)")
//}
//
//print("After update:")
//print(contactList.contacts)

