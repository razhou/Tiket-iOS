//
//  NetworkService.swift
//  Tiket
//
//  Created by Jelajah Data Semesta on 21/04/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

typealias JsonDictionay = [String : Any]

enum ServiceResponse{
    case success(message:String?,response: Data)
    case failureError(error: NSError?)
    case failureResponse
    case notConnectedToInternet
}

enum ResponseStatusCode: Int {
    case success = 200
}

class NetworkService: NSObject {
    
    ///Add the network logger on the configuration
    var dataRequestArray : [DataRequest]=[]
    var sessionManager : Alamofire.SessionManager?
    // custom configuration
    var session: URLSession?
    let configuration = URLSessionConfiguration.default
    
    override init() {
        super.init()
        
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        sessionManager = Alamofire.SessionManager(configuration:configuration)
        
        
    }
    
    /// This call for method, get (Default),post, put, delete
    ///
    /// - Parameters:
    ///   - endPoint: Endpoit url
    ///   - method: method
    ///   - header: headar
    ///   - params: parameter
    ///   - completion: completion handler
    func callEndPoint(endPoint : String, method : Alamofire.HTTPMethod = .get, params: JsonDictionay? = [:], completion: @escaping (ServiceResponse) -> Void) {
        
        let url = Constants.baseUrl + (endPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        
        switch method {
            
        case .post:
            
            self.sessionManager?.request(url, method: method, parameters: params, encoding:URLEncoding.httpBody, headers: setHeaders()).responseJSON(completionHandler: { (response: DataResponse<Any>) in
                
                self.serializeResponse(response: response, completion: completion)
            })
            
            
        default:
            
            self.sessionManager?.request(url, method: method, parameters: params, headers: nil).responseJSON(completionHandler: {
                (response: DataResponse<Any>) in
                
                self.serializeResponse(response: response, completion: completion)
            })
        }
        
        
    }
    
    /// Serialized object of response
    ///
    /// - Parameters:
    ///   - response: Data of response
    ///   - completion: Service Response
    func serializeResponse(response: DataResponse<Any>, completion:@escaping(ServiceResponse) -> Void) {
        
        
        if let jsonResponse = response.data  {

            self.successResult(result:jsonResponse, completion: completion)
            
        }else{
            
            if let error = response.result.error as NSError?, error.code ==
                NSURLErrorNotConnectedToInternet{
                self.notConnectedToInternet(completion: completion)
                
            } else {
                
                completion(.failureError(error:response.result.error as NSError? ))
            }
            
            return
        }
        
        
        
    }
    
    
    // Success API Result Custom
    ///
    /// - Parameters:
    ///   - result: response from API
    ///   - headers: header API
    ///   - completion: Service response
    func successResult(result: Data, completion:@escaping(ServiceResponse) -> Void) {
        
//        guard let response = result else {
//
//            completion(.failureResponse)
//            return
//        }

        completion(.success(message: "SUCCESS", response: result))
        
    }
    
    
    /// Not connected to internet function
    ///
    /// - Parameter completion: Service Response
    func notConnectedToInternet(completion:@escaping(ServiceResponse) -> Void ){
        completion(.notConnectedToInternet)
        
        
    }
    
    
    /// Cancell Request Api
    func cancellAllRequest() {
        
        for dataRequest in dataRequestArray{
            
            dataRequest.cancel()
        }
        
        self.dataRequestArray.removeAll()
        
    }
    
    // MARK : - Set Header
    /// Get headers
    ///
    /// - Returns: param of headers
    func setHeaders() -> HTTPHeaders {
        
        var headers: HTTPHeaders?
        headers = ["Accept" : "application/json"]
        return headers!
        
    }
}
