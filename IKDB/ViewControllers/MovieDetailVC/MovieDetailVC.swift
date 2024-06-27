//
//  MovieDetailVC.swift
//  IKDB
//
//  Created by Siros Taib on 6/27/24.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class MovieDetailVC: UIViewController {
    
    private let myBag = DisposeBag()
    
    // View Model
    private var viewModel: DetailViewModel!
    
    // IBOutlets:
    @IBOutlet var backView: UIView!
    @IBOutlet weak var myImagePosterView: UIImageView!
    @IBOutlet weak var myTitleLabel: UILabel!
    @IBOutlet weak var myDescriptionLabel: UILabel!
    @IBOutlet weak var myRatingLabel: UILabel!
    @IBOutlet weak var myDateLabel: UILabel!
    
    @IBOutlet weak var myPrevButton: UIButton!
    @IBOutlet weak var myNextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = UIColor(named: "mainColor")

        // Do any additional setup after loading the view.
        setupUI()
        bindViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configure(with viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    func setupUI(){
        myImagePosterView.roundX(15)
        
        // Setup initial UI state based on currentIndexRelay value
        updateButtonVisibility()
    }
    
    func updateMovieOutlets(with movieValue: SimpleMovieModel){
        self.myTitleLabel.text = movieValue.name
        self.myDescriptionLabel.text = movieValue.description
        self.myRatingLabel.text = "Rating: " + (movieValue.rating)
        self.myDateLabel.text = "Date: " + (movieValue.date)
        self.myImagePosterView.sd_setImage(with: movieValue.image)
    }
    
    private func bindViewModel() {
        
        // Observe currentIndexRelay to update button visibility
        viewModel.currentIndexRelay
            .subscribe(onNext: { [weak self] _ in
                self?.updateButtonVisibility()
            })
            .disposed(by: myBag)
        
        viewModel.totalMoviesCountRelay
                   .subscribe(onNext: { [weak self] _ in
                       self?.updateButtonVisibility()
                       
                   })
                   .disposed(by: myBag)
        
        myNextButton.rx.tap
            .bind(to: viewModel.nextButtonTapped)
            .disposed(by: myBag)
        
        myPrevButton.rx.tap
            .bind(to: viewModel.previousButtonTapped)
            .disposed(by: myBag)
        
        viewModel.currentMovie
            .drive(onNext: { [weak self] movie in
                let movieParsed = SimpleMovieModel(movie: movie)
                self?.updateMovieOutlets(with: movieParsed)
            })
            .disposed(by: myBag)
    }
    
    func updateButtonVisibility() {
        let currentIndex = viewModel.currentIndexRelay.value
        
        let totalMoviesCount = viewModel.totalMoviesCountRelay.value
        
        // Update button visibility based on currentIndex and totalMoviesCount
        myNextButton.isHidden = currentIndex >= totalMoviesCount - 1
        myPrevButton.isHidden = currentIndex == 0
    }
}
