//
//  CoreDataManager.swift
//  UrlSessionCache
//
//  Created by ihor on 06.07.2023.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UrlSessionCache")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {}
    
    func saveContext() {
        let context = CoreDataManager.shared.managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchListsFromCache(completion: @escaping (Lists?) -> Void) {
        let context = CoreDataManager.shared.managedObjectContext
        context.perform {
            let fetchRequest: NSFetchRequest<ListsEntity> = NSFetchRequest<ListsEntity>(entityName: "ListsEntity")
            do {
                if let listsEntity = try context.fetch(fetchRequest).first {
                    let listResultsFetchRequest: NSFetchRequest<ListResultEntity> = NSFetchRequest<ListResultEntity>(entityName: "ListResultEntity")
                    listResultsFetchRequest.predicate = NSPredicate(format: "parentList == %@", listsEntity)
                    let listResultEntities = try context.fetch(listResultsFetchRequest)
                    let listResults = listResultEntities.map { listResultEntity -> ListResult in
                        return ListResult(
                            list_name: listResultEntity.list_name ?? "",
                            display_name: listResultEntity.display_name ?? "",
                            list_name_encoded: listResultEntity.list_name_encoded ?? "",
                            oldest_published_date: listResultEntity.oldest_published_date ?? "",
                            newest_published_date: listResultEntity.newest_published_date ?? ""
                        )
                    }
                    let lists = Lists(
                        status: listsEntity.status ?? "",
                        copyright: listsEntity.copyright ?? "",
                        num_results: Int(listsEntity.num_results),
                        results: listResults
                    )
                    completion(lists)
                } else {
                    completion(nil)
                }
            } catch {
                print("Failed to fetch ListsEntity from cache: \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchBooksFromCache(listNameEncoded: String, completion: @escaping (BookResult?) -> Void) {
        let context = CoreDataManager.shared.managedObjectContext
        context.perform {
            let fetchRequest: NSFetchRequest<BookResultEntity> = NSFetchRequest<BookResultEntity>(entityName: "BookResultEntity")
            fetchRequest.predicate = NSPredicate(format: "list_name_encoded == %@", listNameEncoded)
            do {
                if let booksEntity = try context.fetch(fetchRequest).first {
                    let bookResultsFetchRequest: NSFetchRequest<BookEntity> = NSFetchRequest<BookEntity>(entityName: "BookEntity")
                    bookResultsFetchRequest.predicate = NSPredicate(format: "parentList == %@", booksEntity)
                    let bookResultEntities = try context.fetch(bookResultsFetchRequest)
                    let bookResults = bookResultEntities.map { bookResultEntity -> Book in
                        return Book(rank: Int(bookResultEntity.rank),
                                    rank_last_week: Int(bookResultEntity.rank_last_week),
                                    weeks_on_list: Int(bookResultEntity.weeks_on_list),
                                    asterisk: Int(bookResultEntity.asterisk),
                                    dagger: Int(bookResultEntity.dagger),
                                    primary_isbn10: bookResultEntity.primary_isbn10 ?? "",
                                    primary_isbn13: bookResultEntity.primary_isbn13 ?? "",
                                    publisher: bookResultEntity.publisher ?? "",
                                    description: bookResultEntity.descrription ?? "",
                                    price: bookResultEntity.price ?? "",
                                    title: bookResultEntity.title ?? "",
                                    author: bookResultEntity.author ?? "",
                                    contributor: bookResultEntity.contributor ?? "",
                                    contributor_note: bookResultEntity.contributor_note ?? "",
                                    book_image: bookResultEntity.book_image ?? "",
                                    book_image_width: Int(bookResultEntity.book_image_width),
                                    book_image_height: Int(bookResultEntity.book_image_height),
                                    amazon_product_url: bookResultEntity.amazon_product_url ?? "",
                                    age_group: bookResultEntity.age_group ?? "",
                                    book_review_link: bookResultEntity.book_review_link ?? "",
                                    first_chapter_link: bookResultEntity.first_chapter_link ?? "",
                                    sunday_review_link: bookResultEntity.sunday_review_link ?? "",
                                    article_chapter_link: bookResultEntity.article_chapter_link ?? "",
                                    book_uri: bookResultEntity.book_uri ?? "")
                    }
                    
                    let books = BookResult(list_name: booksEntity.list_name ?? "",
                                           list_name_encoded: booksEntity.list_name_encoded ?? "",
                                           bestsellers_date: booksEntity.bestsellers_date ?? "",
                                           published_date: booksEntity.published_date ?? "",
                                           published_date_description: booksEntity.published_date_description ?? "",
                                           next_published_date: booksEntity.next_published_date ?? "",
                                           previous_published_date: booksEntity.previous_published_date ?? "",
                                           display_name: booksEntity.display_name ?? "",
                                           normal_list_ends_at: Int(booksEntity.normal_list_ends_at),
                                           books: bookResults)
                    completion(books)
                } else {
                    completion(nil)
                }
            } catch {
                print("Failed to fetch ListsEntity from cache: \(error)")
                completion(nil)
            }
        }
    }
}
