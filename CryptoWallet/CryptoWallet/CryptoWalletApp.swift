//
//  CryptoWalletApp.swift
//  CryptoWallet
//
//  Created by ihor on 05.10.2022.
//

import SwiftUI

@main
struct CryptoWalletApp: App {
    var isLogged = UserDefaults.standard.bool(forKey: "isLogged")
    var body: some Scene {
        WindowGroup {
            if isLogged {
                MainView()
            } else {
                EasinessView()
            }
        }
    }
}
