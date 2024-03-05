//
//  School.swift
//  nyc
//
//  Created by Cincinnati Ai on 3/5/24.
//

import Foundation

struct School {
    let dbn: String
    let schoolName: String?
    let overviewParagraph: String?
    let academicOportunities: String?
}

extension School: Hashable {}

extension School: Codable {
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case overviewParagraph = "overview_paragraph"
        case academicOportunities = "academicopportunities1"
    }
}
