//
//  NetworkingConstant.swift
//  IKDB
//
//  Created by Siros Taib on 6/24/24.
//

import Foundation

class NetworkingConstant {
    public static var shared: NetworkingConstant = NetworkingConstant()
    
    private init() {
        // singleton
    }
    
    public var apiKey: String {
        get {
            return "4a06669b886242b8f805e61ea75a43e6"
        }
    }
    
    public var baseURL: String {
        get {
            return "https://api.themoviedb.org/3/"
        }
    }
    
    public var imageServerURL: String {
        get {
            return "https://image.tmdb.org/t/p/w500"
        }
    }
    
    
}
