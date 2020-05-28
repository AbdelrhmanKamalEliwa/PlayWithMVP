//
//  RepoVCRouter.swift
//  PlayWithMVP
//
//  Created by Abdelrhman Eliwa on 5/19/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class RepoVCRouter {
    
    private enum Constants {
        static let identifier = "UINavigationController"
    }
    
    class var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    class func createRepoVC() -> UIViewController {
        let navigationController = mainStoryboard.instantiateViewController(identifier: Constants.identifier)
        let repoView = navigationController.children.first as? RepoView
        let interactor = RepoInteractor()
        let router = RepoVCRouter()
        let presenter = RepoVCPresenter(view: repoView, interactor: interactor, router: router)
        repoView?.presenter = presenter
        return navigationController
    }
    
    func navigateToRepoDetailsScreen(from view: RepoView?, repo: RepoModel) {
        let repoDetailsView = RepoDetailsVCRouter.createRepoDetailsVC(repo: repo)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(repoDetailsView, animated: true)
        }
    }
}
