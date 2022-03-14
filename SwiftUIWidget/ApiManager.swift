//
//  ApiManager.swift
//  SwiftUIWidget
//
//  Created by Smin Rana on 3/14/22.
//

import Foundation

enum ApiResult {
    case success
    case fail
}

protocol QuoteProtocol {
    func getDailyQuote(completion: @escaping(_ result: ApiResult, _ data: Any?) -> () )
}

class DailyQuoteApi: QuoteProtocol {
    var quote: QuoteModel?
    
    func getDailyQuote(completion: @escaping (_ result: ApiResult, _ data: Any?) -> ()) {
        guard let url = URL(string: "https://sminrana.com/sample-api/quote.php") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else { return }
            if error == nil {
                completion(.success, data)
            } else {
                completion(.fail, nil)
            }
        }.resume()
    }
}


