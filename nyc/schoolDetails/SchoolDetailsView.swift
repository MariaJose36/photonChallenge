//
//  SchoolDetailsView.swift
//  nyc
//
//  Created by Cincinnati Ai on 3/5/24.
//

import SwiftUI

struct SchoolDetailsView: View {
    @ObservedObject var viewModel: SchoolDetailsViewModel
    
    init(viewModel: SchoolDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                VStack(alignment: .leading, content: {
                    Text(viewModel.details.name)
                        .font(.title)
                })
                Spacer()
            }
            .padding(.bottom)
            
            Text("Some opportunities it offers:")
                .font(.headline)
            Text(viewModel.details.academicOportunities)
                .padding(.bottom)
            
            Text("Overview")
                .font(.headline)
            Text(viewModel.details.overviewParagraph)
                .padding(.bottom)
            
        }.padding()
    }
}
