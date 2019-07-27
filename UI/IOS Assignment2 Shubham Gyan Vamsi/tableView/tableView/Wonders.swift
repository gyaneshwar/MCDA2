//
//  Wonders.swift
//  tableView
//
//  Created by MCDA on 2019-07-20.
//  Copyright © 2019 MCDA. All rights reserved.
//

import Foundation

struct Wonders {
    let name: String
    let description : String?
    let userRating: Double?
    let imageURL : String?
    let coordinate: [Double]
    
    init?(wonder: [String: Any]) {
        guard let properties = wonder["properties"] as? [String: Any], let geometry = wonder["geometry"] as? [String: Any] else { return nil}
        self.name = properties["name"] as? String ?? ""
        self.description = properties["description"] as? String ?? ""
        self.userRating = properties["userRating"] as? Double ?? 0.0
        self.imageURL = properties["imageURL"] as? String ?? ""
        self.coordinate = geometry["coordinates"] as? [Double] ?? []
    }
}
