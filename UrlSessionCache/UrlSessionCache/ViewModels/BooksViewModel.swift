//
//  BooksViewModel.swift
//  UrlSessionCache
//
//  Created by ihor on 10.07.2023.
//

import Foundation
import CoreData

protocol BooksViewModelProtocol {
    func decideApplicationFlow(list: ListResult, lists: Lists, completion: @escaping (BookResult?) -> Void)
    func fetchCache(list: ListResult, completion: @escaping (BookResult?) -> Void)
}

class BooksViewModel: BooksViewModelProtocol {
    private let synchronizationQueue = DispatchQueue(label: "com.example.app.bookResultSynchronization")
    
    func decideApplicationFlow(list: ListResult, lists: Lists, completion: @escaping (BookResult?) -> Void) {
        CoreDataManager.shared.fetchBooksFromCache(listNameEncoded: list.list_name_encoded) {  cachedBooks in
            if cachedBooks?.books.count ?? 0 > 0 {
                DispatchQueue.main.async {
                    self.fetchCache(list: list, completion: completion)
                }
            } else {
                DispatchQueue.global(qos: .background).async {
                    self.fetchBooks(listsEntity: lists, completion: completion)
                }
            }
        }
    }
    
    func fetchCache(list: ListResult, completion: @escaping (BookResult?) -> Void) {
        CoreDataManager.shared.fetchBooksFromCache(listNameEncoded: list.list_name_encoded) { [weak self] cachedBooks in
            if let cachedBooks = cachedBooks {
                if cachedBooks.books.count > 0 {
                    self?.synchronizationQueue.sync {
                        completion(cachedBooks)
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func fetchBooks(listsEntity: Lists?, completion: @escaping (BookResult?) -> Void) {
        guard let selections = listsEntity?.results else { return }
        let dispatchGroup = DispatchGroup()
        var bookResults: [BookResult] = []
        
        for selection in selections {
            guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/current/\(selection.list_name_encoded).json?api-key=hBtDzYE3HlJA5yEjWASeyjmMP3qdwHah") else { continue }
            
            dispatchGroup.enter()
            URLSession.shared.dataTask(with: url) { data, _, error in
                defer {
                    dispatchGroup.leave()
                }
                if let error = error {
                    print("Error fetching data: \(error)")
                    return
                }
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                if let bigBook = try? JSONDecoder().decode(Books.self, from: data) {
                    let context: NSManagedObjectContext = CoreDataManager.shared.managedObjectContext
                    let bookResult: BookResult = bigBook.results
                    context.perform {
                        let fetchRequest: NSFetchRequest<BookResultEntity> = NSFetchRequest<BookResultEntity>(entityName: "BookResultEntity")
                        let predicate = NSPredicate(format: "list_name_encoded == %@", bookResult.list_name_encoded)
                        fetchRequest.predicate = predicate
                        let existingListsEntities: [BookResultEntity]? = try? context.fetch(fetchRequest)
                        var bookResultEntity: BookResultEntity?
                        
                        if let existingListsEntities = existingListsEntities {
                            bookResultEntity = existingListsEntities.first
                        }
                        
                        if bookResultEntity == nil {
                            let bookResultEntity: BookResultEntity = BookResultEntity(context: context)
                            bookResultEntity.list_name_encoded = bookResult.list_name_encoded
                            bookResultEntity.list_name = bookResult.list_name
                            bookResultEntity.bestsellers_date = bookResult.bestsellers_date
                            bookResultEntity.published_date = bookResult.published_date
                            bookResultEntity.published_date_description = bookResult.published_date_description
                            bookResultEntity.next_published_date = bookResult.next_published_date
                            bookResultEntity.previous_published_date = bookResult.previous_published_date
                            bookResultEntity.display_name = bookResult.display_name
                            bookResultEntity.normal_list_ends_at = Int16(bookResult.normal_list_ends_at)
                            
                            for result in bookResult.books {
                                let resultEntity: BookEntity = BookEntity(context: context)
                                resultEntity.rank = Int16(result.rank)
                                resultEntity.rank_last_week = Int16(result.rank_last_week)
                                resultEntity.weeks_on_list = Int16(result.weeks_on_list)
                                resultEntity.asterisk = Int16(result.asterisk)
                                resultEntity.dagger = Int16(result.dagger)
                                resultEntity.primary_isbn10 = result.primary_isbn10
                                resultEntity.primary_isbn13 = result.primary_isbn13
                                resultEntity.publisher = result.publisher
                                resultEntity.descrription = result.description
                                resultEntity.price = result.price
                                resultEntity.title = result.title
                                resultEntity.author = result.author
                                resultEntity.contributor = result.contributor
                                resultEntity.contributor_note = result.contributor_note
                                resultEntity.book_image = result.book_image
                                resultEntity.book_image_width = Int16(result.book_image_width)
                                resultEntity.book_image_height = Int16(result.book_image_height)
                                resultEntity.amazon_product_url = result.amazon_product_url
                                resultEntity.age_group = result.age_group
                                resultEntity.book_review_link = result.book_review_link
                                resultEntity.first_chapter_link = result.first_chapter_link
                                resultEntity.sunday_review_link = result.sunday_review_link
                                resultEntity.article_chapter_link = result.article_chapter_link
                                resultEntity.book_uri = result.book_uri
                                
                                bookResultEntity.addToBooks(resultEntity)
                            }
                        }
                        CoreDataManager.shared.saveContext()
                        bookResults.append(bookResult)
                    }
                }
                
            }.resume()
        }
        dispatchGroup.notify(queue: .main) {
            completion(bookResults.last)
        }
    }
}
