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

    var projectLists: BlockchainProjects?

    let headers: HTTPHeaders = [
        "X-LC-Id": "dLH8OSID1Cy0mGypEiYOEXX4-gzGzoHsz",
        "X-LC-Key": "vb7JwLD2eEHiCcYKyjqqTie2,master"
    ]

    func getBlockchainProjects(_ completeHandler: @escaping (_ projects: BlockchainProjects?) -> Void) {
        let params: Parameters = ["limit": "10"]
        sendRequest(params: params, completeHandler)
    }

    func getNextPageProjects(_ cursor: String, _ completeHandler: @escaping (_ projects: BlockchainProjects?) -> Void ) {
        let params: Parameters = ["limit": "10", "cursor": cursor]
        sendRequest(params: params, completeHandler)
    }

    func sendRequest(params: Parameters?, _ completeHandler: @escaping (_ projects: BlockchainProjects?) -> Void ) {
        let url = "https://dlh8osid.api.lncld.net/1.1/scan/classes/BlockChainProject"
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { response in
            print("response result: \(response.result)")
            print("response data: \(String(describing: response.data))")

            switch response.result {
            case .failure:
                return
            case .success:
                if let data = response.data, let result = String(data: data, encoding: .utf8) {
                    completeHandler(self.mapKnowledgesFromJson(result))
                }
            }
        }
    }

    private func mapKnowledgesFromJson(_ json: String) -> BlockchainProjects? {
        print("json \(json)")
        let jsonData = json.data(using: .utf8)!

        let decoder = JSONDecoder()

        return try? decoder.decode(BlockchainProjects.self, from: jsonData)
    }
}
