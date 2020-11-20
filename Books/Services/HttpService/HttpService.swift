//
//  HttpService.swift
//  Books
//
//  Created by Admin on 16.11.2020.
//

import Alamofire

protocol HttpService {
    var sessionManager: Session { get set }
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
