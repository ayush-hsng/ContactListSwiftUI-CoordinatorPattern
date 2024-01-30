//
//  ContactDetailsView.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import SwiftUI

struct ContactDetailsView: View {
    @ObservedObject var contact: ContactViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TextField("Name", text: $contact.name)
                .font(.title)

            HStack {
                Text("Gender:")
                    .font(.headline)
                Text(contact.gender.rawValue)
                    .font(.subheadline)
            }

            HStack {
                Text("Phone Number:")
                    .font(.headline)
                TextField("Enter Phone Number", text: $contact.number)
                    .font(.subheadline)
            }

            Toggle("Blocked", isOn: $contact.isBlocked)
                .font(.headline)

            Spacer()
        }
        .padding()
        .navigationBarTitle(contact.name)
    }
}

#Preview {
    let exampleContact = try! ContactViewModel(name: "John Doe", gender: .male, isBlocked: false, number: "1234567890")
    return ContactDetailsView(contact: exampleContact)
}
