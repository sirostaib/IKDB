//
//  APICaller.swift
//  IKDB
//
//  Created by Siros Taib on 6/22/24.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case couldNotParseData
}

public class APICaller {
    static func getTrendingMovies( completionHandler: @escaping (_ result: Result<MoviesModel, NetworkError>) -> Void) {
        
        let urlString = NetworkingConstant.shared.baseURL + "trending/all/day?api_key=" + NetworkingConstant.shared.apiKey
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(.urlError))
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
           // Code you want to be delayed
            URLSession.shared.dataTask(with: url) { dataResponse, urlResponse, error in
                if error == nil,
                   let data = dataResponse,
                   let resultData = try? JSONDecoder().decode(MoviesModel.self, from: data)
                {
                    completionHandler(.success(resultData))
                }else {
                    completionHandler(.failure(.couldNotParseData))
                }
            }.resume()
         }
        
         
    }
}
