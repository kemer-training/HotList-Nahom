//
//  Result.swift
//  HotList
//
//  Created by NAHØM on 06/01/2023.
//

import Foundation

struct Welcome: Codable{
    var feed: Feed
}

struct Feed: Codable{
//    var listCount = 0
    var results: [Result] = []
}

struct Result: Codable{
    var name: String?
    var artistName: String?
    var artworkUrl100: String?
}
