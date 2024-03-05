//
//  SchoolDetailsViewModel.swift
//  nyc
//
//  Created by Cincinnati Ai on 3/5/24.
//

import Foundation

class SchoolDetailsViewModel: ObservableObject {
    @Published var details: SchoolDetailsUIModel
    
    init(school: School) {
        details = .init(id: school.dbn,
                        name: school.schoolName ?? "-",
                        overviewParagraph: school.overviewParagraph ?? "-",
                        academicOportunities: school.academicOportunities ?? "-")
    }
}
