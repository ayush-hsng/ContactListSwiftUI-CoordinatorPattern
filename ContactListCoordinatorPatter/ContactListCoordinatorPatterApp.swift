//
//  ContactListCoordinatorPatterApp.swift
//  ContactListCoordinatorPatter
//
//  Created by Ayush Kumar Sinha on 23/01/24.
//

import SwiftUI

@main
struct ContactListCoordinatorPatterApp: App {
    @State private var coordinator: AppCoordinator?
    @State private var presentBottomSheet: Bool = false
    var body: some Scene {
        WindowGroup {
            NavigationView(content: {
                switch self.coordinator {
                case let .some(coordinator):
                    coordinator.buildHomePage()
                case .none:
                    EmptyView()
                }
            }).task {
                await self.coordinator = AppCoordinator()
            }
        }
    }
}


