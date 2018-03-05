//
//  DetailViewController.swift
//  flix
//
//  Created by Nancy Gomez on 2/5/18.
//  Copyright © 2018 Nancy Gomez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie = Movie()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        posterImageView.af_setImage(withURL: movie.posterUrl!)
        releaseDateLabel.text = movie.releaseDate
        backDropImageView.af_setImage(withURL: movie.backdropUrl!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
