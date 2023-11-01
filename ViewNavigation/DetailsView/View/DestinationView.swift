//
//  DestinationView.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 9/20/23.
//

import SwiftUI

struct DestinationView: View {
    
    let userName: String
    @ObservedObject var viewModel: DestinationViewModel
    
    var body: some View {
        
        DefaultNavigationView(title: "Details View") {
            VStack {
                Text("Welcome: \(userName)")
                    .padding(.vertical, 16)
                
                if viewModel.displayNewName {
                    Text("New name: \(viewModel.newName)")
                        .padding(.all, 16)
                }
                
                Button("UPDATE NAME") {
                    viewModel.updateUserName(name: userName)
                }
            }
        }
    }
}

struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationView(userName: "test", viewModel: DestinationViewModel())
    }
}
