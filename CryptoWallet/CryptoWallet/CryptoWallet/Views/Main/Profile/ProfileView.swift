//
//  ProfileView.swift
//  CryptoWallet
//
//  Created by ihor on 05.10.2022.
//

import SwiftUI

struct ProfileView: View {
    var buttonColor = Color(red: 39 / 255, green: 43 / 255, blue: 64 / 255)
    var pink = Color(red: 243 / 255, green: 85 / 255, blue: 133 / 255)
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack{
                    VStack {
                        Text("Welcome back,").font(.caption)
                            .foregroundColor(Color.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Mathew 👋🏻").font(.title2)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .foregroundColor(.white)
                    .padding()
                    Spacer()
                    //Image("ball")
                    ImageViewController(imageUrl: "https://thispersondoesnotexist.com/image")
                        .padding()
                }
                Spacer()
                Image("btcIcon")
                Spacer()
                HStack {
                    Button("Deposit"){}
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(buttonColor)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                    Button("Withdraw"){}
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(buttonColor)
                        .cornerRadius(20)
                        .foregroundColor(.white)
                }
                Spacer()
                Section {
                    Text("🔥 Trending")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ProfileTrandingView(title: "Binance Coin", description: "BNB", logoSrc: "bnb", graphSrc: "graph1", cost: "$352,20", percentage: "0.27%")
                            ProfileTrandingView(title: "Cardano", description: "ADA", logoSrc: "ada", graphSrc: "graph2", cost: "$2,936,136.20", percentage: "0.50%")
                        }
                    }
                }
                .padding()
                Section {
                    HStack {
                        Text("🪙 News")
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                        Button("Show all") {}
                            .padding()
                            .foregroundColor(pink)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ProfileNewsView(imageSrc: "news1", category: "Altcoin news", time: "6 min ago", text: "Six XRP Token Holders to Speak in Ripple-SEC Case as Circle Gets Subpoena")
                            ProfileNewsView(imageSrc: "news2", category: "Bitcoin news", time: "6 min ago", text: "Bitcoin Eyes Key Upside Break, Outperforms Ethereum, DOGE Rallies")
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
