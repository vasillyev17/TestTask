//
//  HeaderView.swift
//  CryptoWallet
//
//  Created by ihor on 06.10.2022.
//

import SwiftUI

struct HeaderView: View {
    var backgroundColor = Color(red: 39 / 255, green: 43 / 255, blue: 64 / 255)
    
    var body: some View {
        VStack {
            HStack {
                Button("") {}
                    .background(Image("back"))
                    .frame(maxWidth: 30, alignment: .leading)
                Text("BTC/USD")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.trailing)
                    .padding(.trailing)
            }
            .padding()
            Text("$ 49 298.69 ").font(.title)
                .foregroundColor(.white)
                .padding()
            Text("-0.27%")
                .foregroundColor(Color.pink)
                .padding()
            HStack {
                VStack {
                    Text("24h Low").font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.trailing)
                    Text("$ 45 848")
                        .foregroundColor(.white)
                        .padding(.leading)
                        .padding(.trailing)
                }
                VStack {
                    Text("24h High").font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.trailing)
                    Text("$ 49300")
                        .foregroundColor(.white)
                        .padding(.leading)
                        .padding(.trailing)
                }
                VStack {
                    Text("Volume (BTC)").font(.caption)
                        .foregroundColor(.gray)
                        .padding(.leading)
                        .padding(.trailing)
                    Text("0.0387")
                        .foregroundColor(.white)
                        .padding(.leading)
                        .padding(.trailing)
                }
            }
            .padding()
        }
        .background(backgroundColor)
        .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
