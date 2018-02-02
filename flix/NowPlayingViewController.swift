//
//  NowPlayingViewController.swift
//  flix
//
//  Created by Nancy Gomez on 2/1/18.
//  Copyright © 2018 Nancy Gomez. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    // UI tableView
    @IBOutlet weak var tableView: UITableView!
    
    // array of dictionaries, initialized
    var movies: [[String: Any]] = []
    
    
    // default func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // We will provide the data for the table view
        tableView.dataSource = self
        
        // API REQUEST -----> {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            // this will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // receives data from url and we make it a json object
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // Now we extract the movies from the json object
                self.movies = dataDictionary["results"] as! [[String: Any]]
                // table view is set up faster than request gets returned, so let's reload!
                self.tableView.reloadData()
            }
        }
        // Start the task to get the info!
        task.resume()
        // } <------- END API REQUEST
    }
    
    // UITableViewDataSource required func
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count;
    }
    
    // UITableViewDataSource required func
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        return cell
    }
    
    // default func
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
