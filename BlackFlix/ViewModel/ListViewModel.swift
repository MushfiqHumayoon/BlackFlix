//
//  ListViewModel.swift
//  BlackFlix
//
//  Created by Mushfiq Humayoon on 23/07/22.
//

import Foundation

class ListViewModel {
    
    let page: Observable<Page?> = Observable(nil)
    let cellViewModels: Observable<[CollectionViewCellViewModel]> = Observable([])
    
    init() {
        buildCellViewModels(of: "1")
    }
    
    func buildCellViewModels(of pageNumber: String) {
        if let page = listData(from: pageNumber) {
            self.page.value = page
            guard let contentItems = page.contentItems.content else { return }
            var itemViewModels = [CollectionViewCellViewModel]()
            contentItems.forEach { content in
                let cellViewModel = CollectionViewCellViewModel(name: content.name, posterImage: content.posterImage)
                itemViewModels.append(cellViewModel)
            }
            if pageNumber != "1" {
                cellViewModels.value.append(contentsOf: itemViewModels)
            } else {
                cellViewModels.value = itemViewModels
            }
        }
    }
    
    func listData(from pageNumber: String) -> Page? {
        let name = "CONTENTLISTINGPAGE-PAGE"+pageNumber
        return loadJson(fileName: name)
    }

    func loadJson(fileName: String) -> Page? {
        let decoder = JSONDecoder()
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url)
        else {
            return nil
        }
        let response = try? decoder.decode(Response.self, from: data)
        return response?.page
    }
}
