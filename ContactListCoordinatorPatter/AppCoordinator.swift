//
//  AppCoordinator.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import Foundation
import SwiftUI

protocol CoordinatorProtocol {
}

enum BottomSheet: String, Hashable, Identifiable {
    case test
    
    var id: String {
        self.rawValue
    }
}

class AppCoordinator: CoordinatorProtocol, AddNewContactFlowCoordinatorDelegate {
    var homePageViewModel: HomePageViewModel
    var contactListModel: ContactListViewModel
    
    init(contactListViewModel: ContactListViewModel? = nil) async {
        self.contactListModel = contactListViewModel ?? ContactListViewModel()
        await self.homePageViewModel = HomePageViewModel(contactListModel: contactListModel)
    }
            
    @ViewBuilder
    func buildHomePage() -> some View {
         HomePageView(viewModel: self.homePageViewModel, navigationCoordinator: self)
    }
    
    @MainActor
    func  pushAddNewContactForm() {
        self.homePageViewModel.activeNavigation = .addNewContact
    }
    
    @MainActor
    func dismissAddNewContactForm() {
        self.homePageViewModel.activeNavigation = nil
    }
}
