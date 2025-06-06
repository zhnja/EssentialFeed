//
//  URLSessionHTTPClient.swift
//  EssentialFeed
//
//  Created by Evgenii Iavorovich on 1/6/25.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentaion: Error {}
    
    private struct URLSessionDataTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionDataTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
    
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: url) { data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse{
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentaion()
                }
            })
        }
            
        task.resume()
        return URLSessionDataTaskWrapper(wrapped: task)
    }
}
