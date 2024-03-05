//
//  NycSchoolsClient.swift
//  nyc
//
//  Created by Cincinnati Ai on 3/5/24.
//

import Foundation

// TODO: add capability for interceptors, to add flexibility
class NycSchoolsClient: NetworkClient {
    func perform<T>(_ request: NetworkRequest) async throws -> T where T : Decodable {
        guard let url = URL(string: Constant.baseUrl + request.path) else { throw Errors.WithMessage("badUrl") }
        let response = try await URLSession.shared.data(from: url)
        // TODO: validate http status codes
        return try JSONDecoder().decode(T.self, from: response.0)
    }
}

extension NycSchoolsClient {
    private enum Constant {
        static let baseUrl = "https://data.cityofnewyork.us/"
    }
}
