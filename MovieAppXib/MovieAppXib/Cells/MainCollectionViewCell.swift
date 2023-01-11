//
//  MainCollectionViewCell.swift
//  MovieAppXib
//
//  Created by Burak Erden on 10.01.2023.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var textBackground: UIImageView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieDetail: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var myImage: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
