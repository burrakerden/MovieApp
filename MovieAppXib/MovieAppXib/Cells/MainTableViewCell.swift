//
//  MainTableViewCell.swift
//  MovieAppXib
//
//  Created by Burak Erden on 10.01.2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDetial: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
