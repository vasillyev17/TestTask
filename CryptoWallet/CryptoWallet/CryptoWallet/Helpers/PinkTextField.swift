//
//  PinkTextField.swift
//  CryptoWallet
//
//  Created by ihor on 07.10.2022.
//

import SwiftUI

struct PinkTextField: View {
    @State var text: String = "0"
    var currency: String
    
    var pinkColor = Color(red: 243 / 255, green: 85 / 255, blue: 133 / 255)
    var body: some View {
        VStack {
            HStack {
                TextField("0", text: $text).font(.title3)
                    .foregroundColor(.white)
                    .placeholder(when: text.isEmpty) {
                        Text("0").foregroundColor(.gray)
                    }
                Text(currency).font(.title3)
                    .foregroundColor(.white)
            }
            .padding(.top)
            Divider()
                .frame(height: 1)
                .padding(.horizontal, 50)
                .background(pinkColor)
            Text("Available: 0 \(currency)").font(.caption)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct PinkTextField_Previews: PreviewProvider {
    static var previews: some View {
        PinkTextField(currency: "")
    }
}
