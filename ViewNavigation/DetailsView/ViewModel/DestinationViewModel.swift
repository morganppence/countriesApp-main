//
//  DestinationViewModel.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 9/20/23.
//

import Foundation
import Combine

protocol DestinationViewProtocol: AnyObject {
    func updateName(name: String)
}

class DestinationViewModel: ObservableObject {
    
    @Published var newName = ""
    @Published var displayNewName = false
    
    var message = CurrentValueSubject<String, Never>("")

    
    weak var delegate: DestinationViewProtocol?
    
    func updateUserName(name: String) {
        guard !name.isEmpty else { return }
        newName = "\(name) bananas"
        displayNewName = true
        NamesManager.shared.updatedName = newName
        delegate?.updateName(name: newName)
        message.send(newName)
    }
    
}
