//
//  FindYourSchoolService.swift
//  nyc
//
//  Created by Cincinnati Ai on 3/5/24.
//

import Foundation

protocol FindYourSchoolServiceContract {
    func getAll() async throws -> [School]
}

class FindYourSchoolService {
    private let client: NetworkClient
    
    init(client: NetworkClient) {
        self.client = client
    }
}

extension FindYourSchoolService: FindYourSchoolServiceContract {
    func getAll() async throws -> [School] {
        try await client.perform(.init(path: "resource/s3k6-pzi2.json"))
    }
}
