//
//  UberCloneApp.swift
//  UberClone
//
//  Created by Anudhi on 02/05/23.
//

import SwiftUI

@main
struct UberCloneApp: App {
    
    @StateObject var locationSearchViewModel = LocationSearchViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
            //this basicallly allow us to use a single instance of the view model at the app level
                .environmentObject(locationSearchViewModel)
        }
    }
}
