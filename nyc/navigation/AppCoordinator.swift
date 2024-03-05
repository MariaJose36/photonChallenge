//
//  AppCoordinator.swift
//  nyc
//
//  Created by Cincinnati Ai on 3/5/24.
//

import Foundation

protocol AppCoordinatorContract {
    func push(screen: AvailableScreen)
}

class AppCoordinator: ObservableObject {
    @Published var screenStack: [AvailableScreen] = []
    
    private init(){}
    static let common = AppCoordinator()
}

extension AppCoordinator: AppCoordinatorContract {
    func push(screen: AvailableScreen) {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.screenStack.append(screen)
        }
    }
}
