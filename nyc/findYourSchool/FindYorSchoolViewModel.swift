//
//  FindYorSchoolViewModel.swift
//  nyc
//
//  Created by Cincinnati Ai on 3/5/24.
//

import Foundation

class FindYourSchoolViewModel: ObservableObject {
    @Published var state: ViewState = .none
    private var rawSchools: [School] = []
    
    private let service: FindYourSchoolServiceContract
    private let coordinator: AppCoordinatorContract
    
    init(service: FindYourSchoolServiceContract, coordinator: AppCoordinatorContract) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func fetchSchools() {
        if case .loading = state { return }
        state = .loading
        Task {
            do {
                let schools = try await service.getAll()
                let cleanedSchools: [SchoolsUIModel] = schools.toUIModel()
                if cleanedSchools.isEmpty {
                    throw Errors.WithMessage("there were no schools to display")
                } else {
                    await MainActor.run {
                        rawSchools.append(contentsOf: schools)
                        state = .schoolsFound(schools: cleanedSchools)
                    }
                }
            } catch {
                // TODO: add analytics
                // TODO: Localize user facing messages
                debugPrint(error)
                await MainActor.run {
                    state = .error(message: "An error occurred.\n Would you like to try again?")
                }
            }
        }
    }
    
    func navigateToDetails(for school: SchoolsUIModel) {
        Task {
            guard let matchingSchool = self.rawSchools.first(where: { $0.dbn == school.id }) else { return }
            coordinator.push(screen: .details(for: matchingSchool))
        }
    }
}

private extension [School] {
    func toUIModel() -> [SchoolsUIModel] {
        self.compactMap {
            guard let name = $0.schoolName else { return nil }
            return .init(id: $0.dbn,
                         name: name,
                         overviewParagraph: $0.overviewParagraph,
                         academicOportunities: $0.academicOportunities)
        }
    }
}

extension FindYourSchoolViewModel {
    enum ViewState {
        case none
        case loading
        case error(message: String)
        case schoolsFound(schools: [SchoolsUIModel])
    }
}

extension FindYourSchoolViewModel.ViewState: Equatable {}
