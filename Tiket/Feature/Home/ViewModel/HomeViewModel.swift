//
//  HomeViewModel.swift
//  Tiket
//
//  Created by Jelajah Data Semesta on 22/04/20.
//  Copyright © 2020 Raju Riyanda. All rights reserved.
//

import Foundation

class HomeViewModel: NetworkService {
    
    private var delegate: HomeViewModelDelegate?
    
    init(delegate: HomeViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchApiGetHeros(){
        self.delegate?.load(isLoad: true)
        callEndPoint(endPoint: ApiPath.allheros.rawValue) { (response) in
            switch response {
            case .success(_, let response):
                do {
                    let heros = try JSONDecoder().decode(Hero.self, from: response)
                    self.delegate?.success(response: heros)
                } catch {
                    self.delegate?.error(error: .failedMappingError)
                }
                self.delegate?.load(isLoad: false)
            case .failureError(let error):
                self.delegate?.error(error: .middlewareError(message: error?.description))
                self.delegate?.load(isLoad: false)
            case .failureResponse:
                self.delegate?.error(error: .invalidJSONError)
               self.delegate?.load(isLoad: false)
            case .notConnectedToInternet:
                self.delegate?.error(error: .connectionError)
                self.delegate?.load(isLoad: false)
            }
        }

    }
    
}

protocol HomeViewModelDelegate {
    func success(response: Hero)
    func error(error: ApiError)
    func load(isLoad: Bool)
}
