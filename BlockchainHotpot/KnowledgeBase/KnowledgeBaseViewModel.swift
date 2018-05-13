//
//  KnowledgeBaseViewModel.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 07/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation
import Alamofire

class KnowledgeBaseViewModel {
    var knowledges: Knowledges?

    func getKnowledgeBases(_ completeHandler: @escaping (_ knoledges: Knowledges?) -> Void ) {

        let headers: HTTPHeaders = [
            "X-LC-Id": "dLH8OSID1Cy0mGypEiYOEXX4-gzGzoHsz",
            "X-LC-Key": "sIqxNzclGr3bXDQKttjUyXvo"
        ]

        Alamofire.request("https://dlh8osid.api.lncld.net/1.1/classes/Knowledges", headers: headers).responseJSON { response in
            print("response result: \(response.result)")
            print("response data: \(String(describing: response.data))")

            if let data = response.data, let result = String(data: data, encoding: .utf8) {
                completeHandler(self.mapKnowledgesFromJson(result))
            }
        }

    }

    func readKnwledgeData() -> String? {
        do {
            if let path = Bundle.main.url(forResource: "Knowledges", withExtension: "json")
            {
                let jsonData = try Data(contentsOf: path)
                let jsonString = String(data: jsonData, encoding: .utf8)
                return jsonString
            }
        } catch  {
            print("file not found")
        }

        return nil
    }
    
    func mapKnowledgesFromJson(_ json: String) -> Knowledges? {
        let jsonData = json.data(using: .utf8)!

        let decoder = JSONDecoder()

        let knowledges = try! decoder.decode(Knowledges.self, from: jsonData)

        return knowledges
    }
}
