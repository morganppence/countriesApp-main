//
//  CountriesView.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 9/29/23.
//

import SwiftUI

struct CountriesView: View {
    
    @ObservedObject var viewModel = CountriesViewModel()

    var body: some View {
        DefaultNavigationView(title: "Countries") {
            if viewModel.viewState == .loading {
                ProgressView()
            } else if viewModel.viewState == .error {
                ErrorView(viewModel: viewModel)
            } else {
                CountriesListView(viewModel: viewModel)
            }
        }
    }
}

struct CountriesListView: View {
    
    let viewModel: CountriesViewModel
    @State var searchValue: String = ""

    var body: some View {
            List(viewModel.searchCountries(searchValue: searchValue)) { country in
                HStack {
                    NavigationLink(destination: CountriesDetailView(country: country)) {
                        VStack(alignment: .leading) {
                            Text("\(country.flag) • \(country.name.common)")
                            Text(viewModel.parseCountryCurrency(currency: country.currencies))
                        }
                    }
                    Spacer()
                }
            }
            .padding(.vertical, 8)
            .searchable(text: $searchValue, prompt: "Find your Country")
            
    }
}

struct ErrorView: View {
    
    let viewModel: CountriesViewModel
    
    var body: some View {
        VStack {
            Image("errorCountry")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button {
                viewModel.tryAgain()
            } label: {
                Text("Try Again")
                    .fontWeight(.semibold)
            }
        }
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView()
    }
}
