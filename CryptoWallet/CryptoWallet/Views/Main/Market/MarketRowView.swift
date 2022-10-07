//
//  MarketRowView.swift
//  CryptoWallet
//
//  Created by ihor on 06.10.2022.
//

import SwiftUI

struct MarketRowView: View {
    var imageSrc: String
    var description: String
    var name: String
    var cost: String
    var percentage: String
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            HStack {
                Image(imageSrc)
                    .resizable()
                    .frame(width: 46.0, height: 46.0)
                VStack {
                    Text(description).font(.title3)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(name)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                Spacer()
                VStack {
                    Text(cost)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text(percentage)
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .listRowBackground(Color.black)
    }
}

struct MarketRowView_Previews: PreviewProvider {
    static var previews: some View {
        MarketRowView(imageSrc: "", description: "", name: "", cost: "", percentage: "")
    }
}
