//
//  FindYourSchoolView.swift
//  nyc
//
//  Created by Cincinnati Ai on 3/5/24.
//

import SwiftUI

struct FindYourSchoolView: View {
    
    init(viewModel: FindYourSchoolViewModel) {
        self.viewModel = viewModel
    }
    
    @ObservedObject var viewModel: FindYourSchoolViewModel
    
    var body: some View {
        viewFactory()
            .onAppear(perform: {
                viewModel.fetchSchools()
            })
    }
}

// MARK: view factories

private extension FindYourSchoolView {
    @ViewBuilder
    func viewFactory() -> some View {
        switch viewModel.state {
        case .none: Text("").accessibilityHidden(true)
        case .loading: ProgressView()
        case .error(let message): errorViewFactory(with: message)
        case .schoolsFound(let schools): schoolsListViewFactory(for: schools)
        }
    }
    
    func errorViewFactory(with message: String) -> some View {
        VStack {
            Button(message, systemImage: "arrow.circlepath") {
                viewModel.fetchSchools()
            }
        }
    }
    
    func schoolsListViewFactory(for list: [SchoolsUIModel]) -> some View {
        List(list) { school in
            VStack(alignment: .leading) {
                Text(school.name)
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Text("Opportunities:")
                    .font(.headline)
                Text(school.academicOportunities ?? "-")
                    .font(.body)
                    .padding(.bottom, 5)
                
                Text("Overview:")
                    .font(.headline)
                Text(school.overviewParagraph ?? "-")
                    .font(.body)
                    .lineLimit(2)
                    .padding(.bottom)
            }
            .onTapGesture {
                viewModel.navigateToDetails(for: school)
            }
        }.accessibilityIdentifier("school list")
    }
}

