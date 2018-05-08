//
//  KnowledgeBaseViewModel.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 07/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation

class KnowledgeBaseViewModel: NSObject {
    var knowledges: Knowledges?

    override init() {
        super.init()
    }

    func getKnowledgeBases() -> Knowledges? {
        return mapKnowledgesFromJson(readKnwledgeData()!)
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
