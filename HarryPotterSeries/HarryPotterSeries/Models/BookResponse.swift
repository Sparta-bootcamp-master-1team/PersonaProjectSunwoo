//
//  BookResponse.swift
//  HarryPotterSeries
//
//  Created by 조선우 on 3/28/25.
//

import Foundation

struct Chapters: Decodable {
    var title: String
}

struct Book: Decodable {
    var title: String
    var author: String
    var pages: Int
    var dedication: String
    var summary: String
    var wiki: String
    var chapters: [Chapters]
}

struct Attributes: Decodable {
    var attributes: Book
}

struct BookResponse: Decodable {
    var data: [Attributes]
}
