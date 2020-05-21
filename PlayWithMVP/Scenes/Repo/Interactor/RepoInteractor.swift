//
//  RepoInteractor.swift
//  PlayWithMVP
//
//  Created by Abdelrhman Eliwa on 5/19/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

class RepoInteractor {
    
    func getRepos(completionHandler: @escaping ([RepoModel]?, Error?) -> ()) {
        
        let networkManager = NetworkManager()
        _ = networkManager.request(
        url: EndPointRouter.getRepos, httpMethod: .get,
        parameters: nil, headers: nil) { (result: APIResult<[RepoModel]>) in
            
            switch result {
            case .success(let data):
                completionHandler(data, nil)
            case .failure(let error):
                completionHandler(nil, error)
            case .decodingFailure(let error):
                completionHandler(nil, error)
            case .badRequest(let error):
                completionHandler(nil, error)
            }
        }
    }
}
