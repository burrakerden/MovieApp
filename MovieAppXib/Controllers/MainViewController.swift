//
//  MainViewController.swift
//  MovieAppXib
//
//  Created by Burak Erden on 10.01.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var service = Service()
    var refleshControl = UIRefreshControl()
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var movies = [Result]()
    var sliderMovies = [Result]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        searchButton()
    }

//MARK: - Fetch Data
    
    func getData() {
        service.getSearchMovieList(text: "") { result in
            guard let result = result?.results else {return}
            self.movies = result
            for _ in 0...2 {
                self.sliderMovies.append(self.movies[0])
                self.movies.remove(at: 0)
            }
            self.setupUI()
        } onError: { error in
            print(error)
        }
    }
    
    //MARK: - Bar Buttons / Reflesh Cont
    
    private func searchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }

    @objc func searchTapped() {
        let vc2 = SearchTableViewController()
        navigationController?.pushViewController(vc2, animated: true)
        }
    
    @objc func reflesh(send: UIRefreshControl) {
        DispatchQueue.main.async {
            self.myTableView.reloadData()
            self.refleshControl.endRefreshing()
        }
    }
    
//MARK: - Setup UI
    
    func setupUI() {
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.rowHeight = 112
        self.myCollectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        self.myTableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        title = "Movies"
        navigationItem.backButtonTitle = ""
        refleshControl.addTarget(self, action: #selector(reflesh), for: UIControl.Event.valueChanged)
        myTableView.addSubview(refleshControl)
    }
}

//MARK: - Collection View

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell else {return UICollectionViewCell()}
        let imageBaseUrl = "https://image.tmdb.org/t/p/w1280" + (sliderMovies[indexPath.row].backdropPath ?? "")
        let image2 = cell.movieImage
        image2?.downloaded(from: imageBaseUrl, contentMode: .scaleAspectFill)
        cell.movieName.text = sliderMovies[indexPath.row].title
        cell.movieDetail.text = sliderMovies[indexPath.row].overview
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
            guard let id1 = (sliderMovies[indexPath.row].id) else {return}
            vc.movieID = String(id1)
            navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - Table View

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MainTableViewCell = myTableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        let imageBaseUrl = "https://image.tmdb.org/t/p/w1280" + (movies[indexPath.row].posterPath ?? "")
        let image1 = cell.movieImage
        image1?.downloaded(from: imageBaseUrl)
        cell.movieName.text = movies[indexPath.row].title
        cell.movieDetial.text = movies[indexPath.row].overview
        cell.movieDate.text = movies[indexPath.row].releaseDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = DetailViewController()
            guard let id1 = (movies[indexPath.row].id) else {return}
            vc.movieID = String(id1)
            navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Page Control

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
