//
//  SelectionsViewModel.swift
//  UrlSessionCache
//
//  Created by ihor on 10.07.2023.
//

import Foundation
import CoreData

protocol SelectionsViewModelProtocol {
    func decideApplicationFlow(completion: @escaping (Lists?) -> Void)
    func fetchCache(completion: @escaping (Lists?) -> Void)
}

class SelectionsViewModel: SelectionsViewModelProtocol {
    private let synchronizationQueue = DispatchQueue(label: "com.example.app.bookResultSynchronization")

    func decideApplicationFlow(completion: @escaping (Lists?) -> Void) {
        CoreDataManager.shared.fetchListsFromCache {  cachedLists in
            if cachedLists?.num_results ?? 0 > 0 {
                DispatchQueue.main.async {
                    self.fetchCache(completion: completion)
                }
            } else {
                DispatchQueue.global(qos: .background).async {
                    self.fetchLists(completion: completion)
                }
            }
        }
    }
    
    func fetchCache(completion: @escaping (Lists?) -> Void) {
        CoreDataManager.shared.fetchListsFromCache { cachedLists in
            if let cachedLists = cachedLists {
                if cachedLists.results.count > 0 {
                    completion(cachedLists)
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func fetchLists(completion: @escaping (Lists?) -> Void) {
        guard let url = URL(string: "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=hBtDzYE3HlJA5yEjWASeyjmMP3qdwHah") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            if let lists = try? JSONDecoder().decode(Lists.self, from: data) {
                let context = CoreDataManager.shared.managedObjectContext
                context.perform {
                    let fetchRequest: NSFetchRequest<ListsEntity> = NSFetchRequest<ListsEntity>(entityName: "ListsEntity")
                    if let existingListsEntity = try? context.fetch(fetchRequest).first {
                        existingListsEntity.status = lists.status
                        existingListsEntity.num_results = Int16(lists.num_results)
                        existingListsEntity.results = nil
                        
                        for listResult in lists.results {
                            let listResultEntity = ListResultEntity(context: context)
                            listResultEntity.list_name = listResult.list_name
                            listResultEntity.display_name = listResult.display_name
                            listResultEntity.list_name_encoded = listResult.list_name_encoded
                            listResultEntity.oldest_published_date = listResult.oldest_published_date
                            listResultEntity.newest_published_date = listResult.newest_published_date
                            
                            existingListsEntity.addToResults(listResultEntity)
                        }
                    } else {
                        let listsEntity = ListsEntity(context: context)
                        listsEntity.status = lists.status
                        listsEntity.num_results = Int16(lists.num_results)
                        for listResult in lists.results {
                            let listResultEntity = ListResultEntity(context: context)
                            listResultEntity.list_name = listResult.list_name
                            listResultEntity.display_name = listResult.display_name
                            listResultEntity.list_name_encoded = listResult.list_name_encoded
                            listResultEntity.oldest_published_date = listResult.oldest_published_date
                            listResultEntity.newest_published_date = listResult.newest_published_date
                            
                            listsEntity.addToResults(listResultEntity)
                        }
                    }
                    CoreDataManager.shared.saveContext()
                }
                self.synchronizationQueue.sync {
                    completion(lists)
                }
            }
        }.resume()
    }
}
