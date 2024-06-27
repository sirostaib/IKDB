//
//  DetailViewModel.swift
//  IKDB
//
//  Created by Siros Taib on 6/27/24.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewModel {
    private let disposeBag = DisposeBag()
    
    // Input
    let nextButtonTapped = PublishRelay<Void>()
    let previousButtonTapped = PublishRelay<Void>()
    
    // Output
    let currentMovie: Driver<Movie>
    
    private let moviesRelay: BehaviorRelay<[Movie]>
    let currentIndexRelay: BehaviorRelay<Int>
    let totalMoviesCountRelay = BehaviorRelay<Int>(value: 0)
    
    init(movies: [Movie], initialIndex: Int) {
        self.moviesRelay = BehaviorRelay(value: movies)
        self.currentIndexRelay = BehaviorRelay(value: initialIndex)
        self.totalMoviesCountRelay.accept(movies.count)
        
        self.currentMovie = currentIndexRelay
            .map { movies[$0] }
            .asDriver(onErrorDriveWith: .empty())
        
        // Observe changes in moviesRelay to update totalMoviesCountRelay
        moviesRelay
            .map { $0.count }
            .bind(to: totalMoviesCountRelay)
            .disposed(by: disposeBag)
        
        setupBindings()
    }
    
    private func setupBindings() {
        nextButtonTapped
            .withLatestFrom(currentIndexRelay)
            .map { [unowned self] currentIndex in
                let nextIndex = currentIndex + 1
                return nextIndex < self.moviesRelay.value.count ? nextIndex : currentIndex
            }
            .bind(to: currentIndexRelay)
            .disposed(by: disposeBag)
        
        previousButtonTapped
            .withLatestFrom(currentIndexRelay)
            .map { currentIndex in
                let previousIndex = currentIndex - 1
                return previousIndex >= 0 ? previousIndex : currentIndex
            }
            .bind(to: currentIndexRelay)
            .disposed(by: disposeBag)
    }
}
