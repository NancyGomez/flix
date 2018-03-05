//
//  NowPlayingViewController.swift
//  flix
//
//  Created by Nancy Gomez on 2/1/18.
//  Copyright © 2018 Nancy Gomez. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    // UI tableView
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // array of dictionaries, initialized
    var movies: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    // default func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        
        // We will provide the data for the table view
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        
        fetchNowPlaying()
        
    }
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchNowPlaying()
    }
    
    func fetchNowPlaying() {
        // Start dat circle YEET
        activityIndicator.startAnimating()
        
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
            }
        }
    }
    
    // UITableViewDataSource required func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    
    // UITableViewDataSource required func
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.movie = movies[indexPath.row]
    
        // Stop dat circle YEET
        activityIndicator.stopAnimating()
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            print(movie)
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    // default func
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
