//
//  Countries.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 9/29/23.
//

import Foundation

struct Country: Codable, Identifiable {
    var id: Int { return UUID().hashValue }
    var name: CountryName
    var capital: [String]?
    var flag: String
    var population: Int
    var flags: FlagImage
    var coatOfArms: CoatOfArms?
    var currencies: [String: DetailCurrency]?
}

struct CountryName: Codable {
    var common: String
    var official: String
}

struct FlagImage: Codable {
    var png: String
}

struct CoatOfArms: Codable {
    var png: String?
}

struct DetailCurrency: Codable {
    var name: String
    var symbol: String?
}
