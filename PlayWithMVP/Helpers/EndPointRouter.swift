//
//  EndPointRouter.swift
//  Feshar
//
//  Created by Abdelrhman Eliwa on 4/7/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

struct EndPointRouter {
    
    static var getRepos: URL { return URL(string: APIService.baseURL() + "/users/square/repos")! }
    
}
