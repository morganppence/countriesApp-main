//
//  DefaultNavigationView.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 9/20/23.
//

import Foundation
import SwiftUI

struct DefaultNavigationView<Content: View>: View {
    
    var content: Content
    let navBarTitle: String
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.navBarTitle = title
        self.content = content()
    }
    
    var body: some View {
        
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("\(navBarTitle)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 4)
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.blue, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}
