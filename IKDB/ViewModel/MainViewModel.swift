//
//  MainViewModel.swift
//  IKDB
//
//  Created by Siros Taib on 6/24/24.
//

import UIKit
import RxSwift
import RxCocoa


class MainViewModel {
    
    
    let moviesRelay = BehaviorRelay<[Movie]>(value: [])
    var myMovies: Driver<[Movie]> {
        return moviesRelay.asDriver()
    }
    
    private let disposeBag = DisposeBag()
   
    let isLoading = PublishRelay<Bool>()
    lazy var loadingIndicatorSignal: Signal<Bool> = {
        return isLoading.asSignal()
    }()
    
    
    func getMoviesData() {
        isLoading.accept(true)
        APICaller.getTrendingMovies { result in
            switch result {
            case .success(let data):
                print("top trending movies: \(data.results.count)")

                self.moviesRelay.accept(data.results)
                self.isLoading.accept(false)
                
            case .failure(let error):
                print(error.localizedDescription)
                self.isLoading.accept(false)
            }
        }
    }
    
    func getMovies() {
            APICaller.getTrendingMovies { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.moviesRelay.accept(data.results)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
}
