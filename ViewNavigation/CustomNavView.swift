//
//  NavigationView.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 9/27/23.
//

import SwiftUI
import Kingfisher

struct CustomNavView: View {
    
    @ObservedObject var viewModel = CustomViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.countries) { country in
                VStack(alignment: .leading) {
                    HStack {
//                        AsyncImage(url: URL(string: country.flags.png)) { image in
//                            image.resizable()
//                                .frame(width: 25, height: 25)
//                                .aspectRatio(contentMode: .fit)
//                        } placeholder: {
//                            ProgressView()
//                        }
                        KFImage(URL(string: country.flags.png)!)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .aspectRatio(contentMode: .fit)
                        Text("\(country.flag) • \(country.name.common)")
                            .padding(.leading, 4)
                    }
                }
            }
        }
        .navigationTitle("Countries")
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView()
    }
}
