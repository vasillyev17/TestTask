//
//  EasinessView.swift
//  CryptoWallet
//
//  Created by ihor on 05.10.2022.
//

import SwiftUI

struct EasinessView: View {
    let background = Color(red: 39 / 255, green: 43 / 255, blue: 64 / 255)
    let bottomButtonColor = Color(red: 1, green: 139 / 255, blue: 174 / 255)
    let topButtonColor = Color(red: 243 / 255, green: 85 / 255, blue: 133 / 255)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    Image("wallet")
                        .padding()
                        .padding()
                        .padding()
                        .padding()
                        .padding()
                        .padding()
                    VStack {
                        Text("Easiness").font(.largeTitle)
                            .padding()
                            .foregroundColor(.white)
                        Text("Supplying the convenient transactions chains")
                            .padding()
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        NavigationLink(
                            destination: SecurityView(),
                            label: {
                                Text("Continue")
                            })
                            .frame(width: 295, height: 56, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [bottomButtonColor, topButtonColor]),
                                                       startPoint: .leading, endPoint: .trailing)
                                            .cornerRadius(30))
                    }
                    .padding(.bottom)
                    .background(background)
                    .cornerRadius(30)
                    Spacer()
                }
                .frame(minWidth: 335, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .frame(minHeight: 266, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct EasinessView_Previews: PreviewProvider {
    static var previews: some View {
        EasinessView()
    }
}
