//
//  AddNewContactPageViewModel.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 28/01/24.
//

import Foundation
import SwiftUI

class AddNewContactPageViewModel: ObservableObject {
    @Published var contactListViewModel: ContactListViewModel
    
    @Published var name = ""
    @Published var number = ""
    @Published var selectedGender = Gender.undisclosed.rawValue
    
    @Published var showNameInputValidationInfoBottomSheet: Bool
    @Published var showNumberInputValidationInfoBottomSheet: Bool
    @Published var showInputValidationErrorAlert: Bool
    
    private var coordinator: AddNewContactFlowCoordinator
    
    init(coordinator: AddNewContactFlowCoordinator) {
        self.coordinator = coordinator
        self.contactListViewModel = coordinator.contactListViewModel
        self.showInputValidationErrorAlert = false
        self.showNameInputValidationInfoBottomSheet = false
        self.showNumberInputValidationInfoBottomSheet = false
    }
    
    func createContact() async {
        do {
            try await self.contactListViewModel.createContact(name: name, number: number, gender: Gender(rawValue: selectedGender))
            print("New Contact Created, Updated count of contacts: \(self.contactListViewModel.contacts.count)")
            await self.coordinator.dismiss()
        } catch {
            print("Error creating contact: \(error)")
            await self.alert()
        }
    }
    
    @MainActor
    func cancel() {
        self.coordinator.dismiss()
    }
    
    @MainActor
    func alert() {
        self.showInputValidationErrorAlert = true
    }
    
    @MainActor
    func showNumberInputValidationInfo() {
        self.showNumberInputValidationInfoBottomSheet = true
    }
    
    @MainActor
    func showNameInputValidationInfo() {
        self.showNameInputValidationInfoBottomSheet = true
    }
}
