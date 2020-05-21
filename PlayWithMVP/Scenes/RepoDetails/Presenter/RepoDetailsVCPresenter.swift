//
//  RepoDetailsPresenter.swift
//  PlayWithMVP
//
//  Created by Abdelrhman Eliwa on 5/21/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import Foundation

protocol RepoDetailsView: class {
    var presenter: RepoDetailsVCPresenter? { get set}
    func showIndicator()
    func hideIndicator()
    func displayRepoImage(_ imageUrl: String?)
    func displayRepoData()
    func showError(error: String)
}

protocol RepoDetailsCellView {
    func displayCellData(_ data: String)
}

class RepoDetailsVCPresenter {
    
    private weak var view: RepoDetailsView?
    private var repo: RepoModel?
    
    init(repoDetailsView: RepoDetailsView?, repo: RepoModel?) {
        self.view = repoDetailsView
        self.repo = repo
    }
    
    func viewDidLoad() {
        getRepoData()
    }
    
    func getRepoData() {
        view?.showIndicator()
        guard let repo = repo else { return }
        view?.displayRepoImage(repo.owner?.avatarUrl)
        view?.displayRepoData()
        view?.hideIndicator()
    }
    
    func numberOfSections() -> Int {
        TableViewSectionTitleDataSource.init().Titles.count
    }
    
    func numberOfRowsInSection() -> Int {1}
    
    func cellConfigura(cell: RepoDetailsCellView, forSection section: Int, forIndex index: Int) {
        guard let repo = repo else { return }
        let data = [[repo.name], [repo.description], [repo.owner?.login]]
        guard let cellData = data[section][index] else { return }
        cell.displayCellData(cellData)
    }
    
    func setSectionTitle(for section: Int) -> String {
        TableViewSectionTitleDataSource.init().Titles[section]
    }
}
