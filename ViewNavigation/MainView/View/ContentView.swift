//
//  ContentView.swift
//  ViewNavigation
//
//  Created by jhonathan briceno on 9/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var userName: String = ""
    @State var updatedName: String = ""
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        
        NavigationView {
            //Option4
            DefaultNavigationView(title: "Welcome") {
                VStack {
                    
                    /**
                     https://www.hackingwithswift.com/quick-start/swiftui/how-to-let-users-select-pictures-using-photospicker
                     */
                    NavigationLink(destination: PhotosView(), label: {
                        Text("Set Photo")
                    })
                    .padding(16)
                    
                    NavigationLink(destination: MultiplePhotosView(), label: {
                        Text("Set multiple Photos")
                    })
                    .padding(16)
                    
                    Button {
                        viewModel.scheduleNotification()
                    } label: {
                        Text("Schedule Notifiation")
                    }
                    .padding(16)

                    
                    NavigationLink(destination: CountriesView()) {
                        ZStack {
                            Rectangle()
                                .frame(width: 250, height: 60)
                                .foregroundColor(Color.UIColor.buttonGreen)
                                .cornerRadius(10)
                            Text("Visit Countries List")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                        }
                    }
                    
                    Text("Please enter your name")
                        .padding(.vertical, 16)
                    
                    TextField("name", text: $userName)
                    
                    NavigationLink(destination: DestinationView(userName: userName,
                                                                viewModel: viewModel.destinationViewModel)) {
                        Text("Go TO Next View")
                    }
                    
                    if !updatedName.isEmpty {
                        Text("New NAME is: \(updatedName)")
                            .padding(.vertical, 16)
                    }
                    
                    Button("CLEAR") {
                        userName = ""
                        updatedName = ""
                    }
                    .padding(.vertical, 16)

                }
                .padding(.horizontal, 16)
//                .navigationBarTitleDisplayMode(.inline)
//                .toolbar {
//                    ToolbarItem(placement: .principal) {
//                        Text("WELCOME")
//                            .font(.largeTitle)
//                            .fontWeight(.bold)
//                    }
//                }
            }
            .onAppear {
                userName = ""
                updatedName = viewModel.newUpdatedName
            }
            //Option3
//            .blueNavigationBar()
            //Option2
//            .modifier(NavigationBar())
            //Option1
//            .toolbarColorScheme(.dark, for: .navigationBar)
//            .toolbarBackground(Color.blue, for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
//        }
        }
        .alert(isPresented: $viewModel.showNotificationAlert, content: {
            Alert(title: Text("Notification Alert"),
            message: Text("Please allow notifications for app"),
                  dismissButton: .default(Text("Ok")))
        })

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
