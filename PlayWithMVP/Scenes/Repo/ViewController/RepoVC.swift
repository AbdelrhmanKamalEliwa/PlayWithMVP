//
//  ViewController.swift
//  PlayWithMVP
//
//  Created by Abdelrhman Eliwa on 5/19/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit
import SKActivityIndicatorView

class RepoVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    var presenter: RepoVCPresenter?
    fileprivate let interactor = RepoInteractor()
    fileprivate let router = RepoVCRouter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Repos"
        setupTableView()
        presenter = RepoVCPresenter(view: self, interactor: interactor, router: router)
        presenter?.viewDidLoad()
    }

}


// MARK: - Presenter Delegate
extension RepoVC: RepoView {
    
    func showIndicator() {
        DispatchQueue.main.async {
            SKActivityIndicator.show()
        }
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            SKActivityIndicator.dismiss()
        }
    }
    
    func fetchingDataSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(error: String) {
        print(error)
    }
    
}


// MARK: - Setup Table View
extension RepoVC: UITableViewDelegate, UITableViewDataSource {
    
    private enum Constants {
        static let cellIndentifier = "ReposCell"
        static let nibName = "ReposCell"
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: Constants.nibName, bundle: nil),
            forCellReuseIdentifier: Constants.cellIndentifier)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getReposCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIndentifier,
            for: indexPath) as! ReposCell
        presenter?.cellConfingure(cell: cell, for: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(index: indexPath.row)
    }
    
}
