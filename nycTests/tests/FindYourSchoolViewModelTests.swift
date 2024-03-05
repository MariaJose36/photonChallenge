//
//  FindYourSchoolViewModelTests.swift
//  nycTests
//
//  Created by Cincinnati Ai on 3/5/24.
//

@testable import nyc
import XCTest

final class FindYourSchoolViewModelTests: XCTestCase {
    
    private var viewModel: FindYourSchoolViewModel!
    private var service: MockFindYourSchoolService!
    private var coordinator: MockAppCoordinator!

    override func setUpWithError() throws {
        self.service = MockFindYourSchoolService()
        self.coordinator = MockAppCoordinator()
        self.viewModel = FindYourSchoolViewModel(service: service, coordinator: coordinator)
    }

    override func tearDownWithError() throws {
        self.viewModel = nil
        self.service = nil
        self.coordinator = nil
    }

    func test_schoolFetching() throws {
        service.schools = [
            .init(dbn: "a", schoolName: "b", overviewParagraph: nil, academicOportunities: nil),
            .init(dbn: "z", schoolName: nil, overviewParagraph: nil, academicOportunities: nil)
        ]
        
        viewModel.fetchSchools()
        
        let expectation = XCTestExpectation(description: "should receive one school")
        var recevedStates = [FindYourSchoolViewModel.ViewState]()
        let subscription = viewModel.$state.sink { state in
            recevedStates.append(state)
            if case .schoolsFound(_) = state {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 3)
        let expectedStates: [FindYourSchoolViewModel.ViewState] = [
            .loading,
            .schoolsFound(schools: [.init(id: "a", name: "b", overviewParagraph: nil, academicOportunities: nil)])
        ]
        
        XCTAssertEqual(expectedStates, recevedStates)
    }
}
