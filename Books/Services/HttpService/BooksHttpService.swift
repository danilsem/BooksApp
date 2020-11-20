//
//  BooksHttpService.swift
//  Books
//
//  Created by Admin on 16.11.2020.
//

import Foundation
import Alamofire

class BooksHttpService: HttpService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
