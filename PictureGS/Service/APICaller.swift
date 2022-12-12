//
//  APICaller.swift
//  PictureGS
//
//  Created by Игорь Иванюков on 26.11.2022.
//

import Foundation

struct Constants {
    static let API_KEY = "3d5487fd0010706235f1607b8762fd1cad7070bf888e608208cb44cc027c7a38"
    static let baseURL = "https://serpapi.com/search.json?engine=google&"
}

//https://serpapi.com/search.json?engine=google&q=apple&google_domain=google.com&hl=en&tbs=itp%3Aphotos%2Cisz%3Al&tbm=isch&device=mobile&api_key=3d5487fd0010706235f1607b8762fd1cad7070bf888e608208cb44cc027c7a38
//https://serpapi.com/search.json?engine=google&q=Apple&google_domain=google.com&tbs=itp%3Aphotos%2Cisz%3Al&tbm=isch&ijn=1&device=mobile&api_key=3d5487fd0010706235f1607b8762fd1cad7070bf888e608208cb44cc027c7a38
//google_domain=google.com&tbs=itp%3Aphotos%2Cisz%3Al&

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    
    static let shared = APICaller()
    
    func search(with query: String, page: Int, completion: @escaping (Result <[Image], Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.baseURL)q=\(query)&tbm=isch&ijn=\(String(page).capitalizeFirstLetter())&device=mobile&api_key=\(Constants.API_KEY)") else {return print("Не прошел адрес")}
        
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let results = try JSONDecoder().decode(SearchImageResponse.self, from: data)
                completion(.success(results.images_results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
    
    task.resume()
    }

}
