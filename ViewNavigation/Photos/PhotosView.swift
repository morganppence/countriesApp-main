//
//  PhotosView.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 10/25/23.
//

import SwiftUI
import PhotosUI

struct PhotosView: View {
    
    @State private var imageItem: PhotosPickerItem?
    @State private var photoGalleryImage: Image?
    
    var body: some View {
        DefaultNavigationView(title: "Photo Picker") {
            VStack {
                PhotosPicker("Select Image", selection: $imageItem, matching: .images)

                if let photoGalleryImage {
                    photoGalleryImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)

                }
            }
            .onChange(of: imageItem) { _ in
                Task {
                    if let data = try? await imageItem?.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            photoGalleryImage = Image(uiImage: uiImage)
                            return
                        }
                    }

                    print("Failed")
                }
            }
        }
    }
}

#Preview {
    PhotosView()
}
