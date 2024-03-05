//
//  AppNavigationHost.swift
//  nyc
//
//  Created by Cincinnati Ai on 3/5/24.
//

import SwiftUI

struct AppNavigationHost: View {
    private let factories = AppFactories.self
    
    @StateObject
    private var coordinator = AppCoordinator.common
    
    var body: some View {
        NavigationStack(path: $coordinator.screenStack) {
            FindYourSchoolView(viewModel: factories.findYourSchoolViewModelFactory())
                .navigationDestination(for: AvailableScreen.self) { screen in
                    switch screen {
                    case .details(for: let school): SchoolDetailsView(viewModel: factories.schoolDetailsViewModelFactory(for: school))
                    }
                }
        }
    }
}
