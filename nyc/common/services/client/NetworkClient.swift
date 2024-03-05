//
//  NetworkClient.swift
//  nyc
//
//  Created by Cincinnati Ai on 3/5/24.
//

import Foundation

protocol NetworkClient {
    func perform<T: Decodable>(_ request: NetworkRequest) async throws -> T
}
