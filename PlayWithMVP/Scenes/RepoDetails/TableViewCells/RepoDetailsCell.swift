//
//  RepoDetailsCell.swift
//  PlayWithMVP
//
//  Created by Abdelrhman Eliwa on 5/21/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class RepoDetailsCell: UITableViewCell, RepoDetailsCellView {
    
    @IBOutlet weak var textData: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func displayCellData(_ data: String) {
        textData.text = data
    }
    
}
