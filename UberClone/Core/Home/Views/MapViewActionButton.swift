//
//  MapViewActionButton.swift
//  UberClone
//
//  Created by Anudhi on 02/05/23.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var showLocationSearchView : Bool
    
    var body: some View {
        
        Button {
            //action
            withAnimation(.spring()) {
                showLocationSearchView.toggle()
            }
        } label: {
            Image(systemName: showLocationSearchView ? "arrow.left" : "line.3.horizontal")
                .font(.title2)
                .foregroundColor(Color.black)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: .black,radius: 6.0)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(showLocationSearchView: .constant(true))
    }
}
