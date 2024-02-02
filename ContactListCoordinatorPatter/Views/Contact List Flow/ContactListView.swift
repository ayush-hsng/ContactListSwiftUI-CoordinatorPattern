//
//  ContactListView.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import SwiftUI

struct ContactListView: View {
    @ObservedObject var contactListViewModel: ContactListViewModel

    var body: some View {
        List(contactListViewModel.contacts) { contact in
            NavigationLink(destination: ContactDetailsView(contact: contact)) {
                ContactListRowView(contact: contact)
            }
        }
    }
}

#Preview {
    let contacts = try! [
        ContactViewModel(name: "John Doe", gender: .male, isBlocked: false, number: "1234567890"),
        ContactViewModel(name: "Jane Doe", gender: .female, isBlocked: true, number: "9876543210")
    ]
    let contactListViewModel = ContactListViewModel(contacts: contacts)
    return ContactListView(contactListViewModel: contactListViewModel)
}
