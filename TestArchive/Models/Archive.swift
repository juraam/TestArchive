//
//  Archive.swift
//  TestArchive
//
//  Created by Jura Moshkov on 14/03/2019.
//  Copyright © 2019 Jura Moshkov. All rights reserved.
//

import UIKit
import ObjectMapper

class Archive: Mappable {
    var url: String?
    var size: Int?
    var version: Int?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        url     <- map["url"]
        size    <- map["size"]
        version <- map["version"]
    }
}
