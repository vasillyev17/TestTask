//
//  ProfileTrandingView.swift
//  CryptoWallet
//
//  Created by ihor on 06.10.2022.
//

import SwiftUI

struct ProfileTrandingView: View {
    let color = Color(red: 47 / 255, green: 48 / 255, blue: 61 / 255)
    let pink = Color(red: 243 / 255, green: 85 / 255, blue: 133 / 255)
    
    var title: String
    var description: String
    var logoSrc: String
    var graphSrc: String
    var cost: String
    var percentage: String
    var body: some View {
        VStack {
            HStack {
                Image(logoSrc)
                    .resizable()
                    .frame(width: 32.0, height: 32.0)
                    .padding(.leading)
                VStack {
                    Text(title).font(.title3)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(description).font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Image(graphSrc)
                .resizable()
                .frame(width: 180.0, height: 32.0)
                .padding()
            HStack {
                Text(cost).font(.caption)
                    .foregroundColor(.white)
                    .padding(.leading)
                Spacer()
                Text(percentage).font(.caption)
                    .foregroundColor(pink)
                    .padding(.trailing)
            }
        }
        .frame(width: 194, height: 155, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .background(color)
        .cornerRadius(20)
    }
}

struct ProfileTrandingView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTrandingView(title: "", description: "", logoSrc: "", graphSrc: "", cost: "", percentage: "")
    }
}
