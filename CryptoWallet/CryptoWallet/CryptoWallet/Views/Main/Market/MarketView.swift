//
//  MarketView.swift
//  CryptoWallet
//
//  Created by ihor on 06.10.2022.
//

import SwiftUI

struct MarketView: View {
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .black
        UITableView.appearance().backgroundColor = .black
    }
    
    @State private var showingSheet = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack {
                List {
                    MarketRowView(imageSrc: "eth", description: "Etherium", name: "ETH", cost: "$2678.95", percentage: "+4.95%")
                    MarketRowView(imageSrc: "eth2", description: "Etherium 2", name: "ETH2", cost: "$2,383.65", percentage: "+4.91%")
                    MarketRowView(imageSrc: "usdt", description: "Tether", name: "USDT", cost: "$2.00", percentage: "-0.05%")
                    MarketRowView(imageSrc: "bnb", description: "Binance Coin", name: "BNB", cost: "$352.50", percentage: "-0.27%")
                    MarketRowView(imageSrc: "ada", description: "Cardano", name: "ADA", cost: "$2,836,137.20", percentage: "+4.11%")
                    MarketRowView(imageSrc: "link", description: "Chain link", name: "LINK", cost: "$2,836,137.20", percentage: "+2.23%")
                    MarketRowView(imageSrc: "btc", description: "Bitcoin", name: "BTC", cost: "$36,751.20", percentage: "+2.23%")
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    showingSheet.toggle()
                }
                .sheet(isPresented: $showingSheet) {
                    CurrencyView()
                }
            }
        }
        .navigationBarHidden(true)
    }
}

struct MarketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketView()
    }
}
