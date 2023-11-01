//
//  MultiplePhotosView.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 10/25/23.
//

import SwiftUI
import PhotosUI


struct MultiplePhotosView: View {
    
    @State private var selectedItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        DefaultNavigationView(title: "Photo Picker") {
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        ForEach(0..<selectedImages.count, id: \.self) { i in
                            selectedImages[i]
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                        }
                    }
                }
                .toolbar {
                    PhotosPicker("Select images", selection: $selectedItems, matching: .images)
                }
                .onChange(of: selectedItems) { _ in
                    Task {
                        selectedImages.removeAll()
                        
                        for item in selectedItems {
                            if let data = try? await item.loadTransferable(type: Data.self) {
                                if let uiImage = UIImage(data: data) {
                                    let image = Image(uiImage: uiImage)
                                    selectedImages.append(image)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MultiplePhotosView()
}
