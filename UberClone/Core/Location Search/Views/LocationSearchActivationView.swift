//
//  LocationSearchActivationView.swift
//  UberClone
//
//  Created by Anudhi on 02/05/23.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack {
            Rectangle()
                .fill(Color.black)
                .frame(width: 8.0 , height : 8.0)
                .padding(.horizontal)
            
            Text("Where to?")
                .foregroundColor(Color.gray)
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color: .black , radius: 6.0)
        )
    }
}

struct LocationSearchActivationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivationView()
    }
}
