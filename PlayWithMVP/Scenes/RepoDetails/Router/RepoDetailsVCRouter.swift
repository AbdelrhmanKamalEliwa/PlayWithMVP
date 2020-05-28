//
//  RepoDetailsVCRouter.swift
//  PlayWithMVP
//
//  Created by Abdelrhman Eliwa on 5/21/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class RepoDetailsVCRouter {
    
    private enum Constants {
        static let identifier = "RepoDetailsVC"
    }
    
    class var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    
    class func createRepoDetailsVC(repo: RepoModel) -> UIViewController {
        let repoDetailsVC = mainStoryboard.instantiateViewController(withIdentifier: Constants.identifier)
        if let repoDetailsView = repoDetailsVC as? RepoDetailsView {
            let presenter = RepoDetailsVCPresenter(repoDetailsView: repoDetailsView, repo: repo)
            repoDetailsView.presenter = presenter
        }
        return repoDetailsVC
    }
}
