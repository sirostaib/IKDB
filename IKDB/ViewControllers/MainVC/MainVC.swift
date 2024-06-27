//
//  MainVC.swift
//  IKDB
//
//  Created by Siros Taib on 6/23/24.
//

import UIKit
import RxSwift
import RxCocoa

class MainVC: UIViewController {
    
    // IBOutlets:
    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl: UIRefreshControl!
    
    // Activity Indicator
    var activityIndicator: UIActivityIndicatorView!
    
    // ViewModels:
    var viewModel: MainViewModel = MainViewModel() // MainViewModel(myMovies: Driver.of([]))
    var myBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        
        // Do any additional setup after loading the view.
        configView()
        viewModel.getMoviesData()
        setupRefreshControl()
        bindTableView()
    }
    
    func setupLoadingIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        
        // This is just for testing:
        // navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        
        view.addSubview(activityIndicator)
        layoutLoadingUI()
        
        observeLoadingSignal()
    }
    
    func observeLoadingSignal() {
        viewModel.loadingIndicatorSignal
            .emit(onNext: { isLoading in
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            })
            .disposed(by: myBag)
    }
    
    func layoutLoadingUI() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configView() {
        self.title = "IKDB - Trending"
        self.view.backgroundColor = UIColor(named: "mainColor")
        self.navigationController?.navigationBar.tintColor = UIColor(named: "mainColor")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barStyle = .black
        
        setupTableView()
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        
        // Bind the refresh control's refresh action
        refreshControl.rx.controlEvent(.valueChanged)
            .bind { [weak self] in
                print("getting movies, Refreshing...")
                self?.viewModel.getMovies()
            }
            .disposed(by: myBag)
    }
    
    private func bindTableView() {
        viewModel.myMovies
            .drive(onNext: { [weak self] newMovies in
                guard let self = self else { return }
                // End refreshing
                self.refreshControl.endRefreshing()
                // Reload table view with new data
                self.tableView.reloadData()
                
            })
            .disposed(by: myBag)
    }

}
