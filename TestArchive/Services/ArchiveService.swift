//
//  ItemService.swift
//  TestArchive
//
//  Created by Jura Moshkov on 14/03/2019.
//  Copyright © 2019 Jura Moshkov. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ArchiveService {
    static let shared = ArchiveService()
    
    func loadItems(completion: @escaping (([Archive]) -> Void), failure: @escaping ((String) -> Void)) {
        Alamofire.request("http://vetmag.xclm.ru/data/ziplist/distr3/0/").responseJSON { response in
            switch response.result {
            case .success(let result):
                guard let dict = result as? [String:Any],
                    let arrayItems = dict["ziplist"] as? [[String:Any]]
                    else {
                        failure("Неправильный формат данных")
                        return
                }
                let array = Mapper<Archive>().mapArray(JSONArray: arrayItems)
                completion(array)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
