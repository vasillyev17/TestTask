//
//  ProfileNewsView.swift
//  CryptoWallet
//
//  Created by ihor on 06.10.2022.
//

import SwiftUI

struct ProfileNewsView: View {
    var imageSrc: String
    var category: String
    var time: String
    var text: String
    
    var body: some View {
        HStack {
            Image(imageSrc)
                .resizable()
                .frame(width: 80.0, height: 80.0)
                .cornerRadius(10)
            VStack {
                HStack {
                    Text(category).font(.caption)
                        .foregroundColor(.gray)
                    Text("•")
                        .foregroundColor(.gray)
                    Text(time).font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Text(text)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct ProfileNewsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileNewsView(imageSrc: "", category: "", time: "", text: "")
    }
}
