//
//  HomePageViewModel.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 02/02/24.
//

import Foundation
import SwiftUI

@MainActor
class HomePageViewModel: ObservableObject {
    @Published var contactListModel: ContactListViewModel
    @Published var activeNavigation: HomePageNavigation?
    
    init(contactListModel: ContactListViewModel) {
        self.contactListModel = contactListModel
        self.activeNavigation = nil
    }
}
