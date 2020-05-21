//
//  RepoVCPresenter.swift
//  PlayWithMVP
//
//  Created by Abdelrhman Eliwa on 5/19/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

protocol RepoView: class {
    var presenter: RepoVCPresenter? { get set }
    func showIndicator()
    func hideIndicator()
    func fetchingDataSuccess()
    func showError(error: String)
}

protocol RepoCellView {
    func displayUserName(_ userName: String)
    func displayOwnerName(_ ownerName: String)
    func displayDescription(_ description: String)
    func displayUserImage(_ userImageUrl: String?)
}

class RepoVCPresenter {
    
    private weak var view: RepoView?
    private let interactor: RepoInteractor
    private let router: RepoVCRouter
    private var repos = [RepoModel]()
    
    init(view: RepoView?, interactor: RepoInteractor, router: RepoVCRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        getRepos()
    }
    
    func getRepos() {
        view?.showIndicator()
        interactor.getRepos { [weak self] (repos, error) in
            guard let self = self else { return }
            self.view?.hideIndicator()
            if let error = error {
                self.view?.showError(error: error.localizedDescription)
            } else {
                guard let repos = repos else { return }
                self.repos = repos
                self.view?.fetchingDataSuccess()
            }
            
        }
    }
    
    func getReposCount() -> Int {
        repos.count
    }
    
    
    func cellConfingure(cell: RepoCellView, for index: Int) {
        let repo = repos[index]
        
        let userName = repo.name
        cell.displayUserName(userName)
        
        guard let owner = repo.owner else { return }
        guard let ownerName = owner.login else { return }
        cell.displayOwnerName(ownerName)
        
        guard let description = repo.description else { return }
        cell.displayDescription(description)
        
        let userImage = owner.avatarUrl
        cell.displayUserImage(userImage)

    }
    
    func didSelectRow(index: Int) {
        let repo = repos[index]
        router.navigateToRepoDetailsScreen(from: view, repo: repo)
    }
}
