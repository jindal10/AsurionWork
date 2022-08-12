//
//  PetModel.swift
//  AsurionCodingWork
//
//  Created by Gaurav Jindal on 02/08/22.
//

import Foundation

struct Pets: Codable {
    var pets: [PetModel]?
}

struct PetModel: Codable {
    var imageUrl: String?
    var title: String?
    var contentUrl: String?
    var dateAdded: String?
    
    private enum CodingKeys: String, CodingKey {
        case imageUrl = "image_url"
        case title
        case contentUrl = "content_url"
        case dateAdded = "date_added"
    }
}
