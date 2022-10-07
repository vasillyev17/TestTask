//
//  MainView.swift
//  CryptoWallet
//
//  Created by ihor on 06.10.2022.
//

import SwiftUI

struct MainView: View {
    @State var selection = 0
    
    init() {
        UITabBar.appearance().barTintColor = UIColor(Color.black)
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ProfileView()
                .tabItem {
                    if selection == 0 {
                        Image("tab1filled")
                    } else {
                        Image("tab1")
                    }
                }.tag(0)
            
            MarketView()
                .tabItem {
                    if selection == 1 {
                        Image("tab2filled")
                    } else {
                        Image("tab2")
                    }
                }.tag(1)
        }
        
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
