//
//  SearchTableViewController.swift
//  MovieAppXib
//
//  Created by Burak Erden on 11.01.2023.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
        
    @IBOutlet weak var searchBar: UISearchBar!
    var service = SearchService()
    var movies = [Result]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Config

    func setupUI() {
        tableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        searchBar.delegate = self
        tableView.rowHeight = 112
    }
    
    
    func getData(text: String) {
        service.getSearchMovieList(text: text) { result in
            guard let result = result?.results else {return}
            self.movies = result
            self.tableView.reloadData()
        } onError: { error in
            print(error)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {return UITableViewCell()}
        cell.searchName.text = movies[indexPath.row].title
        let imageBaseUrl = "https://image.tmdb.org/t/p/w1280" + (movies[indexPath.row].posterPath ?? "")
        let image2 = cell.searchImage
        image2?.downloaded(from: imageBaseUrl)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        guard let id1 = (movies[indexPath.row].id) else {return}
        vc.movieID = String(id1)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Search Bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
                
        if searchText.count >= 3 {
            getData(text: searchText)
        } else {
            movies.removeAll()
            tableView.reloadData()
        }
    }
}
