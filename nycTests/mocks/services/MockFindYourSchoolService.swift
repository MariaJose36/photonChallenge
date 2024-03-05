//
//  MockFindYourSchoolService.swift
//  nycTests
//
//  Created by Cincinnati Ai on 3/5/24.
//

@testable import nyc
import Foundation

class MockFindYourSchoolService: FindYourSchoolServiceContract {
    var schools: [School]?
    func getAll() async throws -> [School] {
        guard let schools = schools else { throw Errors.WithMessage("no schools found")}
        return schools
    }
}
