//
//  CustomTableCell.swift
//  IKDB
//
//  Created by Siros Taib on 6/25/24.
//

import UIKit
import SDWebImage

class CustomTableCell: UITableViewCell {
    
    static var identifier: String {
        get {
            "CustomTableCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "CustomTableCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
        backView.roundX(15)
        backView.addBorderX(color: .lightGray, width: 1)
        
        movieImageView.roundX(10)
        
    }
    
    // IBOutlets:
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(viewModel: SimpleMovieModel) {
        self.movieTitleLabel.text = viewModel.name
        self.movieDateLabel.text = viewModel.date
        self.movieRatingLabel.text = viewModel.rating
        self.movieImageView.sd_setImage(with: viewModel.image)
    }
    
}
