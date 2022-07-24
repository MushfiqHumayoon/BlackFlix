//
//  Page.swift
//  BlackFlix
//
//  Created by Mushfiq Humayoon on 23/07/22.
//

import Foundation

struct Response: Decodable {
    var page: Page
}
struct Page: Decodable {
    var title: String
    var totalContentItems: String
    var pageNum: String
    var pageSize: String
    var contentItems: ContentItems
    
    enum CodingKeys: String, CodingKey {
        case title
        case totalContentItems = "total-content-items"
        case pageNum = "page-num"
        case pageSize = "page-size"
        case contentItems = "content-items"
    }
}
struct ContentItems: Decodable {
    var content: [Content]?
}
struct Content: Decodable {
    var name: String?
    var posterImage: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case posterImage = "poster-image"
    }
}
