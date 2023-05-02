//
//  LocationSearchResultCell.swift
//  UberClone
//
//  Created by Anudhi on 02/05/23.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var body: some View {
        HStack() {
            
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .frame(width:40, height:40)
                .foregroundColor(.blue)
                .accentColor(.white)
            
            VStack(alignment: .leading, spacing: 4.0) {
                Text("Coffee")
                    .font(.body)
                Text("Saket, Malviya Nagar")
                    .font(.system(size: 15.0))
                    .foregroundColor(.gray)
                
                Divider()
            }
            .padding(.leading ,8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell()
    }
}
