//
//  HomePageView.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 24/01/24.
//

import SwiftUI

enum HomePageNavigation: String, Hashable, Identifiable {
    case addNewContact
    
    var id: String {
        self.rawValue
    }
}

struct HomePageView: View {
    @ObservedObject var viewModel: HomePageViewModel
    var navigationCoordinator: AppCoordinator
    var body: some View {
        VStack(spacing: 16) {
            // ContactListView at the top
            ContactListView(contactListViewModel: self.viewModel.contactListModel)
            
            //CTA Button at bottom
            NavigationLink(tag: HomePageNavigation.addNewContact, selection: self.$viewModel.activeNavigation) {
                self.presentNewContactView()
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
        }.navigationTitle("Contacts")
    }
    
    @ViewBuilder
    private func presentNewContactView() -> some View {
        let addNewContactFlowCoordinator = AddNewContactFlowCoordinator(contactListViewModel: self.viewModel.contactListModel, delegate: self.navigationCoordinator)
        
        addNewContactFlowCoordinator.buildAddNewContactCoordinatorView()
    }
}

#Preview {
    let contacts = try! [
        ContactViewModel(name: "John Doe", gender: .male, isBlocked: false, number: "1234567890"),
        ContactViewModel(name: "Jane Doe", gender: .female, isBlocked: true, number: "9876543210")
    ]
    let contactListViewModel = ContactListViewModel(contacts: contacts)
    var appCoordinator: AppCoordinator? = nil
    return NavigationView {
        switch appCoordinator {
        case let .some(coordinator):
            coordinator.buildHomePage()
        case .none:
            EmptyView().task {
                await appCoordinator = AppCoordinator(contactListViewModel: contactListViewModel)
            }
        }
    }
}
