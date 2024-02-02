//
//  AddNewCoordinatorView.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import SwiftUI

struct AddNewContactPageView: View {
    @ObservedObject var viewModel: AddNewContactPageViewModel
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        self.viewModel.showNameInputValidationInfo()
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundColor(.blue)
                    }.padding()
                }
                AddNewContactForm(name: self.$viewModel.name, number: self.$viewModel.number, selectedGender: self.$viewModel.selectedGender)
            }
            Button {
                Task {
                    await self.viewModel.createContact()
                }
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
        }
        .navigationTitle("New Contact")
        .alert(isPresented: self.$viewModel.showInputValidationErrorAlert, content: {
                Alert(title: Text("Invalid Input"), message: Text("Please enter a valid name and a 10-digit mobile number."), dismissButton: .default(Text("OK")))
        }).sheet(isPresented: self.$viewModel.showNameInputValidationInfoBottomSheet, content: {
            self.contactNameValidationInfoBottomSheet()
                .sheet(isPresented: self.$viewModel.showNumberInputValidationInfoBottomSheet, content: {
                    self.contactNumberValidationInfoBottomSheet()
                })
        })
    }

    func onDismiss() {
        print("Dismissing Bottom Sheet")
    }
    
    @ViewBuilder
    func contactNumberValidationInfoBottomSheet() -> some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Section(header: Text("Contact Number Requirements")) {
                        Text("Should be a 10-digit number")
                            .padding()
                    }
                }
                Spacer()
            }
            Spacer().frame(height: 300)
        }
    }
    
    
    @ViewBuilder
    func contactNameValidationInfoBottomSheet() -> some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.viewModel.showNumberInputValidationInfo()
                }) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.blue)
                }.padding()
            }
            Section(header: Text("Contact Name Requirements"), content: {
                Text("Should be non Empty")
                    .padding()
            })
            
            Section(header: Text("Contact Number Requirements")) {
                Text("Should be a 10-digit number")
                    .padding()
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
    return NavigationView {
        AddNewContactPageView(viewModel: AddNewContactPageViewModel(coordinator: AddNewContactFlowCoordinator(contactListViewModel: contactListViewModel, delegate: nil)))
    }
}
