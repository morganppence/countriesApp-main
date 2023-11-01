//
//  CountriesViewModel.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 9/29/23.
//

import Foundation

class CountriesViewModel: ObservableObject {
    
    enum ViewState {
        case loading
        case error
        case content
    }
    
    var countries = [Country]()
    @Published var viewState: ViewState = .loading
    private var dataClient = DataClient()
        
    init() {
        getAllCountries()
    }
    
    func getAllCountries() {
        Task { @MainActor in
            do {
                guard let url = URL(string: "https://restcountries.com/v3.1/all") else {
                    viewState = .error
                    return 
                }
                let urlRequestDetails = UrlRequestDetails(url: url)
                countries = try await dataClient.requestWithAsync(urlRequestDetails: urlRequestDetails)
                viewState = .content
            } catch {
                print("Error: \(error.localizedDescription)")
                viewState = .error
            }
        }
    }
    
    func searchCountries(searchValue: String) -> [Country] {
        if searchValue.isEmpty{
            return countries
        } else {
            return countries.filter { $0.name.common.contains(searchValue)}
        }
    }
    
    func tryAgain() {
        viewState = .loading
        getAllCountries()
    }
    
    func parseCountryCurrency(currency: [String: DetailCurrency]?) -> String {
        guard let countryCurrency = currency else { return "Not Available"}
        
        var currency = "Not available"
        
        if let currencyCode = countryCurrency.keys.first,
           let countryDetails = countryCurrency[currencyCode] {
            
            currency = countryDetails.name
        }

        return currency
    }
}
