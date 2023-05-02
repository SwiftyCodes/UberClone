//
//  Locatio nSearchView.swift
//  UberClone
//
//  Created by Anudhi on 02/05/23.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocation = ""
    @State private var destinationLocation = ""
    @Binding var showLocationSearchView : Bool
    
    var body: some View {
        VStack() {
            
            //Menu Button
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
                        .foregroundColor(.white)
                    
                    TextField("Where to?", text: $destinationLocation)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
                .padding(.vertical)
            
            //List View
            ScrollView{
                VStack(alignment: .leading) {
                    ForEach(0..<20, id: \.self) { _ in
                        LocationSearchResultCell()
                    }
                }
            }
        }
        .background(.white)
    }
}

struct Locatio_nSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(showLocationSearchView: .constant(true))
    }
}
