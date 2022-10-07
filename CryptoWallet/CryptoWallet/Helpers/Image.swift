//
//  Image.swift
//  CryptoWallet
//
//  Created by ihor on 07.10.2022.
//

import SwiftUI

import Combine
import SwiftUI
struct ImageViewController: View {
    @ObservedObject var url: LoadUrlImage

    init(imageUrl: String) {
        url = LoadUrlImage(imageURL: imageUrl)
    }

    var body: some View {
          Image(uiImage: UIImage(data: self.url.data) ?? UIImage())
              .resizable()
            .frame(width: 50, height: 50, alignment: .trailing)
            .cornerRadius(50)
    }
}

class LoadUrlImage: ObservableObject {
    @Published var data = Data()
    init(imageURL: String) {
        let cache = URLCache.shared
        let request = URLRequest(url: URL(string: imageURL)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
        if let data = cache.cachedResponse(for: request)?.data {
            self.data = data
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response {
                let cachedData = CachedURLResponse(response: response, data: data)
                                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.data = data
                    }
                }
            }).resume()
        }
    }
}
