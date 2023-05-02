//
//  HomeView.swift
//  UberClone
//
//  Created by Anudhi on 02/05/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var showLocationSearchView = false
    
    var body: some View {
        ZStack(alignment: .top) {
            
            //Map View
            UberMapViewRepresentable()
                .ignoresSafeArea()
            
            //Menu Button
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading)
                .padding(.top, 4.0)
            
            if showLocationSearchView {
                LocationSearchView(showLocationSearchView: $showLocationSearchView)
            }else {
                //Home Screen
                LocationSearchActivationView()
                    .padding(.top, 72.0)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showLocationSearchView.toggle()
                        }
                    }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
