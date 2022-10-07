//
//  CurrencyView.swift
//  CryptoWallet
//
//  Created by ihor on 05.10.2022.
//

import SwiftUI

struct CurrencyView: View {
    @State var text: String = "5"
    
    var buttonColor = Color(red: 39 / 255, green: 43 / 255, blue: 64 / 255)
    var pink = Color(red: 243 / 255, green: 85 / 255, blue: 133 / 255)
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    HeaderView()
                    PinkTextField(text: "5", currency: "BTC")
                    PinkTextField(text: "", currency: "USD")
                    HStack {
                        Button("     \(Text("Buy BTC").font(.title3)) \(Text("\n1 067 620 USD ≈ 5 BTC").font(.caption))"){}
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(buttonColor)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                        Button("     \(Text("Sell BTC").font(.title3)) \(Text("\n15 BTC ≈ 86 672.7 USD").font(.caption))"){}
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(buttonColor)
                            .cornerRadius(20)
                            .foregroundColor(.white)
                    }
                    Section {
                        Text("💸 About BTC").font(.title2)
                            .foregroundColor(.white)
                            .padding(.top)
                            .padding(.bottom)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Bitcoin is a decentralized digital currency created in January 2009. It follows the ideas set out in a whitepaper by the mysterious and pseudonymous Satoshi Nakamoto. The identity of the person or persons who created the technology is still a mystery. Bitcoin offers the ")
                            .foregroundColor(.white)
                            .lineLimit(7)
                        Button("Show more +") {}
                            .foregroundColor(pink)
                    }
                    VStack {
                        HStack {
                            Text("Rank")
                                .foregroundColor(.white)
                                .frame(maxWidth: 150, alignment: .leading)
                                .padding()
                            Spacer()
                            Text("№1")
                                .foregroundColor(.gray)
                                .frame(maxWidth: 150, alignment: .trailing)
                                .padding()
                        }
                        .frame(width: 334, height: 47, alignment: .center)
                        .background(buttonColor)
                        .cornerRadius(10)
                        .padding(.bottom)
                        .padding(.top)
                        HStack {
                            Text("Launch Date")
                                .foregroundColor(.white)
                                .frame(maxWidth: 150, alignment: .leading)
                                .padding()
                            Spacer()
                            Text("January 3, 2009")
                                .foregroundColor(.gray)
                                .frame(maxWidth: 150, alignment: .trailing)
                                .padding()
                        }
                        .frame(width: 334, height: 47, alignment: .center)
                        .background(buttonColor)
                        .cornerRadius(10)
                    }
                }
            }
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
