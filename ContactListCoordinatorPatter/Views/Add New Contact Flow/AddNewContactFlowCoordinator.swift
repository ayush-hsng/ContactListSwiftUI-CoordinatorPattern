//
//  AddNewContactFlowCoordinator.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 25/01/24.
//

import Foundation
import SwiftUI

protocol AddNewContactFlowCoordinatorProtocol: ObservableObject, CoordinatorProtocol {
    var contactListViewModel: ContactListViewModel { get }
    
    func dismiss()
}

protocol AddNewContactFlowCoordinatorDelegate {
    func pushAddNewContactForm()
    func dismissAddNewContactForm()
}

class AddNewContactFlowCoordinator: AddNewContactFlowCoordinatorProtocol {
    @Published var contactListViewModel: ContactListViewModel
    
    var delegate: (any AddNewContactFlowCoordinatorDelegate)?
    
    @MainActor
    init(contactListViewModel: ContactListViewModel, delegate: (any AddNewContactFlowCoordinatorDelegate)? = nil) {
        self.contactListViewModel = contactListViewModel
        self.delegate = delegate
    }
    
    @MainActor
    func dismiss() {
        self.delegate?.dismissAddNewContactForm()
    }
    
    func buildAddNewContactCoordinatorView() -> some View {
        let addNewContactFlowCoordinator = AddNewContactPageViewModel(coordinator: self)
        return AddNewContactPageView(viewModel: addNewContactFlowCoordinator)
    }
}
