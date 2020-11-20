//
//  HttpRouter.swift
//  Books
//
//  Created by Admin on 16.11.2020.
//

import Alamofire

protocol HttpRouter: URLRequestConvertible {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var headers: HTTPHeaders? { get }
    func body() throws -> Data?
    
    func request(using httpService: HttpService) throws -> DataRequest
}

extension HttpRouter {
    var parameters: Parameters? { return nil }
    var headers: HTTPHeaders? { return nil }
    
    func body() throws -> Data? { return nil }
    
    func asURLRequest() throws -> URLRequest {
        var url = try baseURL.asURL()
        url.appendPathComponent(path)
        
        var request = try URLRequest(url: url, method: method, headers: headers)
        request = try URLEncoding.default.encode(request, with: parameters)
        request.httpBody = try body()
        return request
    }
    
    func request(using httpService: HttpService) throws -> DataRequest {
        return try httpService.request(asURLRequest())
    }
}
