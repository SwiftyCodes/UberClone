//
//  Locatio nSearchView.swift
//  UberClone
//
//  Created by Anudhi on 02/05/23.
//

import SwiftUI

struct LocationSearchView: View {
    
    @StateObject var viewModel = LocationSearchViewModel()
    @State private var startLocation = ""
    @State private var destinationLocation = ""
    @Binding var showLocationSearchView : Bool
    
    var body: some View {
        VStack() {
            
            //Back Button
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading)
            
            //Header View
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray4))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray4))
                        .frame(width: 1, height: 24)
                    
                    Circle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack {
                    TextField("Start Location", text: $startLocation)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
                .padding(.vertical)
            
            //List View
            ScrollView{
                VStack(alignment: .leading) {
                    ForEach(viewModel.results, id: \.self) { result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                    }
                }
            }
            
//            List {
//                ForEach(viewModel.results, id: \.self) { result in
//                  LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
//              }
//            }
        }
        .background(.white)
    }
}

struct Locatio_nSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(showLocationSearchView: .constant(true))
    }
}
