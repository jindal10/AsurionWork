//
//  NetworkClient.swift
//  AsurionCodingWork
//
//  Created by Gaurav Jindal on 02/08/22.
//

import UIKit

typealias NetworkCompletionHandler = (_ success: Bool, _ response: Any?, _ errorModel: Error?) -> Void
typealias DataParsedCompletionHandler = (_ success: Bool, _ error: Error?) -> Void

class NetworkClient {
    static let sharedClient = NetworkClient()
    private init() {}
    
    // network call
    // use cache for image url
    func getRequestForImage( url: URL, callback: @escaping (_ data: Data?, _ error: Error?) -> Void ) {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            callback(data, error)
        }.resume()
    }
    
    func get( url: URL, callback: @escaping NetworkCompletionHandler) {
        URLSession.shared.dataTask(with: url) { (data, responseObj, error) in
            if let response = responseObj {
                if let httpResponse = response as? HTTPURLResponse {
                    if (200..<300).contains(httpResponse.statusCode) {
                            callback(true, data, error)
                        } else {
                            callback(false, data, error)
                        }
                }
            }
        }.resume()
    }
}
