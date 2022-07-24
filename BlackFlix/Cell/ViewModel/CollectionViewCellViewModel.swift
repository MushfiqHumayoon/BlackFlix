//
//  CollectionViewCellViewModel.swift
//  BlackFlix
//
//  Created by Mushfiq Humayoon on 23/07/22.
//

import Foundation

class CollectionViewCellViewModel {

    var name: Observable<String?> = Observable(nil)
    var posterImage: Observable<String?> = Observable(nil)
    
    init(name: String?, posterImage: String?) {
        self.name.value = name
        self.posterImage.value = posterImage
    }
}
