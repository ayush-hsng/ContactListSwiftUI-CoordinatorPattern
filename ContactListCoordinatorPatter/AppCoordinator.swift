//
//  AppCoordinator.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import Foundation
import SwiftUI

protocol CoordinatorProtocol {
//    func start()
}

enum BottomSheet: String, Hashable, Identifiable {
    case test
    
    var id: String {
        self.rawValue
    }
}

class AppCoordinator: AddNewContactFlowCoordinatorDelegate, CoordinatorProtocol, ObservableObject {
    
    @Published var activeNavigation: HomePageNavigation?
    var contactListModel: ContactListViewModel
    
    @MainActor
    init(contactListViewModel: ContactListViewModel? = nil) {
        self.contactListModel = contactListViewModel ?? ContactListViewModel()
    }
            
    @ViewBuilder
    func buildHomePage() -> some View {
        HomePageView(coordinator: self)
    }
    
    @ViewBuilder
    func buildValidationInfoBottomSheet() -> some View {
        VStack {
            Section(header: Text("Contact Name")) {
                Text("Should be non-empty")
            }
            Section(header: Text("Contact Number")) {
                Text("Should contains only digits")
                Text("SHould be exactlydigits long")
            }
        }
    }
    
    @MainActor
    func pushAddNewContactForm() {
        self.activeNavigation = .addNewContact
    }
    
    @MainActor
    func dismissAddNewContactForm() {
        self.activeNavigation = nil
    }
}
