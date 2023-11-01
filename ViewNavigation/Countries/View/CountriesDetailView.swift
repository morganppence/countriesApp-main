//
//  CountriesDetailView.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 9/30/23.
//

import SwiftUI

struct CountriesDetailView: View {
    
    let country: Country
    
    var body: some View {
        DefaultNavigationView(title: "Country Details") {
            VStack {
                AsyncImage(url: URL(string: "\(country.flags.png)")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 330, height: 400)
                    } else if phase.error != nil {
                        Image("defaultFlag")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 330, height: 400)
                    } else {
                        ProgressView()
                    }
                }
                
                HStack {
                    if let png = country.coatOfArms?.png, let url = URL(string: png) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            case .failure(_):
                                Image("defaultFlag")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            default:
                                ProgressView()
                            }
                        }
                        .frame(width: 150, height: 100)
                    } else {
                        Image("defaultFlag")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 100)
                    }
                    VStack {
                        Text(country.name.common)
                            .font(.system(size: 18))
                            .padding(16)
                        Text("\(country.population)")
                            .font(.system(size: 18))
                    }
                }
            }
        }
    }
}
