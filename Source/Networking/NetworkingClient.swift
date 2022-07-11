//
//  NetworkingClient.swift
//  CoffeeDemo iOS
//
//  Created by Gabriela Bakalova on 5.07.22.
//

import Foundation

enum RestMethod: String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkingClient {
    
    var networkConfiguration: NetworkingConfiguration { get }
    var session: URLSession { get }
    func performRequest<D>(responseType: D.Type, request: NetworkingRequest) async throws -> NetworkingResponse<D> where D : Decodable
}

extension NetworkingClient {
    
    func performRequest<D>(responseType: D.Type, request: NetworkingRequest) async throws -> NetworkingResponse<D> where D : Decodable {
        let urlRequest = self.buildRequest(request: request)
        
        let (responseData, _) = try await session.data(for: urlRequest)
        
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(D.self, from: responseData)
            return NetworkingResponse.success(result: result)
            
        } catch let error {
            
            debugPrint(error)
            return NetworkingResponse.failure(error: NetworkingError.invalidResponseData)
        }
    }
    
    fileprivate func buildRequest(request: NetworkingRequest) -> URLRequest {
        
        var fullURL = networkConfiguration.baseURL.appendingPathComponent(request.path)

        do {
            let parametersDictionary = try request.requestParameters?.asDictionary()
            fullURL = fullURL.addQueryParams(params: parametersDictionary)
        } catch {
            debugPrint("Unable to generate query params for \(request.name)")
        }
  
        var urlRequest = URLRequest(url: fullURL.escapedURL())
        urlRequest.addValue(networkConfiguration.apiKey, forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = request.restMethodType.rawValue
        
        return urlRequest
    }
}
