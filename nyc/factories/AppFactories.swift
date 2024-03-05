//
//  AppFactories.swift
//  nyc
//
//  Created by Cincinnati Ai on 3/5/24.
//

import Foundation

struct AppFactories {
    private static let findYourSchoolViewModel = FindYourSchoolViewModel(service: findYourSchoolServiceFactory(),
                                                                         coordinator: AppCoordinator.common)

    static func findYourSchoolViewModelFactory() -> FindYourSchoolViewModel {
        findYourSchoolViewModel
    }
    
    static func schoolDetailsViewModelFactory(for school: School) -> SchoolDetailsViewModel {
        SchoolDetailsViewModel(school: school)
    }
}

private extension AppFactories {
    static func findYourSchoolServiceFactory() -> FindYourSchoolServiceContract {
        FindYourSchoolService(client: nycNetworkClientFactory())
    }
    
    static func nycNetworkClientFactory() -> NetworkClient {
        NycSchoolsClient()
    }
}
