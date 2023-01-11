//
//  SearchTableViewCell.swift
//  MovieAppXib
//
//  Created by Burak Erden on 11.01.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
