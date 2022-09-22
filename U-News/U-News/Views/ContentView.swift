//
//  ContentView.swift
//  U-News
//
//  Created by ihor on 22.09.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PostsViewModel()
    @State var searchText = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search...", text: $searchText)
                    .padding(.leading, 24)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(10)
            .padding(.horizontal)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    Button(action: {
                        searchText = ""
                        hideKeyboard()
                        
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .padding(.vertical)
                    })
                }
                .padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
            List {
                ForEach(viewModel.posts.filter { "\($0)".lowercased().contains(searchText.lowercased()) || searchText.isEmpty }, id: \.title) { post in
                    ZStack {
                        VStack(alignment: .leading) {
                            CustomImageView(urlString: post.urlToImage ?? "")
                            HStack {
                                Text(post.title ?? "")
                                    .font(.headline)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .lineLimit(0)
                                Text((post.publishedAt?.suffix(9) ?? "").prefix(5))
                                Link(destination: URL(string: post.url ?? "")!) {
                                    Image(systemName: "chevron.right")
                                        .font(.largeTitle)
                                }
                            }
                            Text(post.source.name)
                                .font(.caption)
                            Text(post.description ?? "")
                                .font(.system(size: 11))
                                .foregroundColor(.gray)
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 2)
                }
            }
            
            .listStyle(GroupedListStyle())
            .onAppear(perform: {
                viewModel.loadPosts()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
