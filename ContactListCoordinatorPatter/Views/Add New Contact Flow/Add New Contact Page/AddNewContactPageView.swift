//
//  AddNewCoordinatorView.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import SwiftUI

class AddNewContactPageViewModel: ObservableObject {
    @Published var contactListViewModel: ContactListViewModel
    
    @Published  var name = ""
    @Published var number = ""
    @Published var selectedGender = Gender.undisclosed.rawValue
    
    init(contactListViewModel: ContactListViewModel) {
        self.contactListViewModel = contactListViewModel
    }
    
    func createContact() {
        do {
            try self.contactListViewModel.createContact(name: name, number: number, gender: Gender(rawValue: selectedGender))
            // Save or handle the new contact as needed
            print("New Contact Created, Updated count of contacts: \(self.contactListViewModel.contacts.count)")
        } catch {
            // Handle validation errors or other issues
            print("Error creating contact: \(error)")
        }
    }
}

struct AddNewContactPageView: View {
    @ObservedObject var flowCoordinator: AddNewContactPageViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                AddNewContactForm(name: self.$flowCoordinator.name, number: self.$flowCoordinator.number, selectedGender: self.$flowCoordinator.selectedGender)
                
                Button {
                    self.flowCoordinator.createContact()
                } label: {
                    CTAButtonLabel(backgroundColor: .blue) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 20))
                                .padding(.trailing, 8)
                            Text("Add New Contact")
                                .font(.headline)
                        }
                    }
                }
            }.navigationTitle("New Contact")
        }
    }
}

#Preview {
    let contacts = try! [
        ContactViewModel(name: "John Doe", gender: .male, isBlocked: false, number: "1234567890"),
        ContactViewModel(name: "Jane Doe", gender: .female, isBlocked: true, number: "9876543210")
    ]
    let contactListViewModel = ContactListViewModel(contacts: contacts)
    return AddNewContactPageView(flowCoordinator: AddNewContactPageViewModel(contactListViewModel: contactListViewModel))
}
