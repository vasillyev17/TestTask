//
//  SearchViewModel.swift
//  PrecizeWeather
//
//  Created by ihor on 06.01.2023.
//

import CSVImporter
import Foundation

class SearchViewModel {
    
    func readFromCSV(callback: @escaping ([String]) -> Void) {
        guard let path = Bundle.main.path(forResource: "worldcities", ofType: "csv") else { return }
        var cities: [String] = []
        var row = ""
        DispatchQueue.global(qos: .background).async {
            let importer = CSVImporter<[String]>(path: path)
            importer.startImportingRecords { $0 }.onFinish { importedRecords in
                for record in importedRecords {
                    row = record.joined(separator:",")
                    cities.append(row)
                }
                if !cities.isEmpty {
                    callback(cities)
                }
            }
            
        }
        
    }
}
