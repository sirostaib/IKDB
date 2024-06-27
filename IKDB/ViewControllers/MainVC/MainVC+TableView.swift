//
//  MainVC+TableView.swift
//  IKDB
//
//  Created by Siros Taib on 6/24/24.
//

import Foundation
import UIKit

extension MainVC {
    
    func setupTableView() {
        self.tableView.delegate = nil
        self.tableView.dataSource = nil
        self.tableView.rowHeight = 190
        self.tableView.separatorColor = .clear
        self.tableView.backgroundColor = .clear
        
        self.registerCells()
        
        self.driveData()
        
        self.setupNavigator()
    }
    
    func registerCells() {
        tableView.register(CustomTableCell.register(), forCellReuseIdentifier: CustomTableCell.identifier)
    }
    
    func driveData(){
        // Bind items to tableView
        viewModel.myMovies
            .drive(tableView.rx.items(cellIdentifier: CustomTableCell.identifier, cellType: CustomTableCell.self)) { row, model, cell in
                        // Configure cell
                        cell.setupCell(viewModel: SimpleMovieModel(movie: model))
                    }
                    .disposed(by: myBag)
    
        print(viewModel.myMovies.asObservable().subscribe(onNext: { movies in
            print("updated test: \(movies.count)")
        }))
    }
    
    
    func setupNavigator() {
        tableView.rx.itemSelected
            .map { indexPath in
                return indexPath.row
            }
            .subscribe(onNext: { [weak self] (selectedIndex: Int) in
                guard let self = self else { return }
                
                navigateToDetailViewController(with: viewModel.moviesRelay.value, index: selectedIndex)
                
                // Deselect the row with animation
                if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedIndexPath, animated: true)
                }
            })
            .disposed(by: myBag)
    }
    
    
    
    func navigateToDetailViewController(with movie: [Movie], index: Int) {
        let detailVC = MovieDetailVC.init(nibName: "MovieDetailVC", bundle: Bundle.main)
        let detailViewModel = DetailViewModel(movies: movie, initialIndex: index)
        detailVC.configure(with: detailViewModel)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
