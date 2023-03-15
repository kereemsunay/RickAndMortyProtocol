//
//  DetailViewModel.swift
//  RickAndMortyProtocol
//
//  Created by Kerem on 12.03.2023.
//

import Foundation


protocol DetailViewModelProtocol {
    func viewDidLoad(id:Int)
}

final class DetailViewModel {
    
    var rickAndMortyDetail: Detail?
    var view: DetailViewControllerProtocol?
    var rickAndMortyService: RickAndMortyServiceProtocol
    
    init(rickAndMortyService: RickAndMortyServiceProtocol) {
        self.rickAndMortyService = rickAndMortyService
    }

    private func fetchDetailData(id : Int) {
        rickAndMortyService.fetchDetailData(id: id) { [weak self] res in
            switch res {
            case .success(let data):
                self?.rickAndMortyDetail = data
            case .failure(let error):
                print(error)
            }
        }

    }

}

extension DetailViewModel: DetailViewModelProtocol {
    func viewDidLoad(id:Int) {
        fetchDetailData(id: id)
    }
    
    
}
