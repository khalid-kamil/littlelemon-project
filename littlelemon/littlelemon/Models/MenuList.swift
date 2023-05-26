//
//  MenuList.swift
//  littlelemon
//
//  Created by Khalid Kamil on 19/05/2023.
//

import Foundation

struct MenuList: Decodable {
    var menu: [MenuItem]
}

enum Category: String, CaseIterable {
    case all
    case starters
    case mains
    case desserts
    case sides
}
