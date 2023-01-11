//
//  DetailViewController.swift
//  MovieAppXib
//
//  Created by Burak Erden on 10.01.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailOverview: UILabel!
    @IBOutlet weak var detailRate: UILabel!
    @IBOutlet weak var detailDate: UILabel!
    
    var detailData: Detail?
    var service = DetailService()
    
    var movieID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let id = movieID else {return}
        getDetailData(id: id)
    }

    func getDetailData(id: String) {
        service.getSearchMovieList(id: id) { result in
            guard let result1 = result else {return}
            self.detailData = result1
            self.setupDetail()
        } onError: { error in
            print(error)
        }
    }
    
    func setupDetail() {
        let imageBaseUrl = "https://image.tmdb.org/t/p/w1280" +  (detailData?.backdropPath ?? "")
        detailImage.downloaded(from: imageBaseUrl, contentMode: .scaleAspectFill)
        detailTitle.text = detailData?.title
        detailOverview.text = detailData?.overview
        detailRate.text = String(format: "%.1f", (detailData?.voteAverage ?? 0.0)) + "/10"
        detailDate.text = detailData?.releaseDate
    }

}
