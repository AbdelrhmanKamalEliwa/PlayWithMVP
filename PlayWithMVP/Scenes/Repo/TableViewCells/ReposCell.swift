//
//  ReposCell.swift
//  PlayWithMVP
//
//  Created by Abdelrhman Eliwa on 5/19/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit
import Kingfisher

class ReposCell: UITableViewCell {

    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}


extension ReposCell: RepoCellView {

    func displayUserName(_ userName: String) {
        userNameLabel.text = userName
    }

    func displayOwnerName(_ ownerName: String) {
        ownerNameLabel.text = ownerName
    }

    func displayDescription(_ description: String) {
        descriptionLabel.text = description
    }

    func displayUserImage(_ userImageUrl: String?) {
        if userImageUrl != nil {
            guard let url = URL(string: userImageUrl!) else { return }
            userImage.kf.indicatorType = .activity
            userImage.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                switch result {
                case .success(let image):
                    self.userImage.image = image.image
                case .failure:
                    self.userImage.image = UIImage(named: "UserProfileICON")?.imageFlippedForRightToLeftLayoutDirection()
                    return
                }
            }
        }
    }

}
