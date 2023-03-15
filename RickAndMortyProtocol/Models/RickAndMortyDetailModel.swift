//
//  RickAndMortyDetailModel.swift
//  RickAndMortyProtocol
//
//  Created by Kerem on 12.03.2023.
//

import Foundation

// MARK: - Detail
struct Detail: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}


