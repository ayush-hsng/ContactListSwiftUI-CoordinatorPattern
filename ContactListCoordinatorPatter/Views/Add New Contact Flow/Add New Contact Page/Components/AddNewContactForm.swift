//
//  NewContactForm.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import SwiftUI

struct AddNewContactForm: View {
    @Binding var name: String
    @Binding var number: String
    @Binding var selectedGender: String

    var genderOptions: [String] {
        return Gender.allCases.map { $0.rawValue }
    }

    var body: some View {
        
        Form {
            Section(header: Text("Contact Details")) {
                TextField("Name", text: $name)
                    .keyboardType(.asciiCapable)
                    .autocorrectionDisabled()
                TextField("Number", text: $number)
                    .keyboardType(.numberPad)
                    .autocorrectionDisabled()
            }

            Section(header: Text("Gender")) {
                Picker("Select Gender", selection: $selectedGender) {
                    ForEach(genderOptions, id: \.self) { gender in
                        Text(gender)
                    }
                }
            }
        }
    }
}

#Preview {
    @State var name = ""
    @State var number = ""
    @State var selectedGender = Gender.undisclosed.rawValue
    return AddNewContactForm(name: $name, number: $number, selectedGender: $selectedGender)
}

