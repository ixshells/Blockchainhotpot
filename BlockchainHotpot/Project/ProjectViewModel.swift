//
//  ProjectViewModel.swift
//  BlockchainHotpot
//
//  Created by Tao Xue on 19/05/2018.
//  Copyright © 2018 Tao Xue. All rights reserved.
//

import Foundation
import Alamofire

class ProjectViewModel {

    func getBlockchainProjects(_ completeHandler: @escaping (_ projects: BlockchainProjects?) -> Void ) {

        let headers: HTTPHeaders = [
            "X-LC-Id": "dLH8OSID1Cy0mGypEiYOEXX4-gzGzoHsz",
            "X-LC-Key": "sIqxNzclGr3bXDQKttjUyXvo"
        ]

        Alamofire.request("https://dlh8osid.api.lncld.net/1.1/classes/BlockChainProject", headers: headers).responseJSON { response in
            print("response result: \(response.result)")
            print("response data: \(String(describing: response.data))")

            if let data = response.data, let result = String(data: data, encoding: .utf8) {
                completeHandler(self.mapKnowledgesFromJson(result))
            }
        }
    }

    private func mapKnowledgesFromJson(_ json: String) -> BlockchainProjects? {
        let jsonData = json.data(using: .utf8)!

        let decoder = JSONDecoder()

        let blockchainProjecs = try! decoder.decode(BlockchainProjects.self, from: jsonData)

        return blockchainProjecs
    }
}
