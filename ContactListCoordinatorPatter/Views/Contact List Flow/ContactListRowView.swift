//
//  ContactListRowView.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import SwiftUI

struct ContactListRowView: View {
    @ObservedObject var contact: ContactViewModel
    
    var body: some View {
        HStack {
            Text(contact.name)
                .font(.headline)
            Spacer()
            Text(contact.number)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(8)
    }
    
}

#Preview {
    let exampleContact = try! ContactViewModel(name: "John Doe", gender: .male, isBlocked: false, number: "1234567890")
    return ContactListRowView(contact: exampleContact)
        .previewLayout(.sizeThatFits)
        .padding()
}
