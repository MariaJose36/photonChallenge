//
//  MockAppCoordinator.swift
//  nycTests
//
//  Created by Cincinnati Ai on 3/5/24.
//

@testable import nyc
import Foundation

class MockAppCoordinator: AppCoordinatorContract {
    var lastPublishedScreen: AvailableScreen?
    func push(screen: AvailableScreen) {
        lastPublishedScreen = screen
    }
}
