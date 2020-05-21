//
//  RepoDetailsVC.swift
//  PlayWithMVP
//
//  Created by Abdelrhman Eliwa on 5/21/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit
import SKActivityIndicatorView

class RepoDetailsVC: UIViewController {

    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var presenter: RepoDetailsVCPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
//        presenter = RepoDetailsVCPresenter(view: self, router: RepoDetailsVCRouter(), repo: nil)
        presenter?.viewDidLoad()
    }
}


// MARK: - Presenter Delegate
extension RepoDetailsVC: RepoDetailsView {
    
    func showIndicator() {
        SKActivityIndicator.show()
    }
    
    func hideIndicator() {
        SKActivityIndicator.dismiss()
    }
    
    func displayRepoImage(_ imageUrl: String?) {
        if imageUrl != nil {
            guard let url = URL(string: imageUrl!) else { return }
            repoImageView.kf.indicatorType = .activity
            repoImageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                switch result {
                case .success(let image):
                    self.repoImageView.image = image.image
                case .failure:
                    self.repoImageView.image = UIImage(named: "UserProfileICON")?.imageFlippedForRightToLeftLayoutDirection()
                    return
                }
            }
        }
    }
    
    
    func displayRepoData() {
        tableView.reloadData()
    }
    
    func showError(error: String) {
        print(error)
    }
    
    
}


// MARK: - Setup Table View
extension RepoDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    private enum Constants {
        static let cellIndentifier = "RepoDetailsCell"
        static let nibName = "RepoDetailsCell"
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: Constants.nibName, bundle: nil),
            forCellReuseIdentifier: Constants.cellIndentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIndentifier,
            for: indexPath) as! RepoDetailsCell
        presenter?.cellConfigura(cell: cell, forSection: indexPath.section, forIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter?.setSectionTitle(for: section)
    }
    
}
