//
//  DetailVC.swift
//  IKDB
//
//  Created by Siros Taib on 6/26/24.
//

import UIKit
import SDWebImage

class DetailVC: UIViewController {
    
    // IBOutlets:

    
    
    @IBOutlet weak var myTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // myMovieTitle.text = ""
    }
    
    func updateMovieData(with movie: MovieCellViewModel){
//        if self.myTitle.text != nil {
//            self.myTitle.text = movie.name
//        } else {
//            print("Doesn’t contain a value.")
//        }
        
     //   self.myMovieDescription.text = movie.description
      //  self.myMovieRating.text = movie.rating
      //  self.myImageView.sd_setImage(with: movie.image)
    }

}
