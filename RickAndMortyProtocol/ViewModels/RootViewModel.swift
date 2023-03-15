//
//  RickAndMortyViewModel.swift
//  RickAndMortyProtocol
//
//  Created by Kerem on 5.03.2023.
//

import Foundation

protocol RickAndMortyViewModelProtocol {
    var id : Int { get }
    func viewDidLoad()
    func didSelectItem(at indexPath:IndexPath)
}

final class RootViewModel {
    
    lazy var rickAndMortyResult: [Characters] = [ ]
    var view: RickAndMortyControllerProtocol?
    var rickAndMortyService: RickAndMortyServiceProtocol
    private var page = 0
    private var selectedIndex = 0
    init(rickAndMortyService: RickAndMortyServiceProtocol) {
        self.rickAndMortyService = rickAndMortyService
    }

    private func fetchAllData() {
        rickAndMortyService.fetchAllData(page: page) { [weak self] res in
            switch res {
            case .success(let data):
                self?.rickAndMortyResult.append(contentsOf: data.results)
                self?.view?.reloadData()
            case .failure(let error):
                print(error)
                self?.view?.reloadData()
            }
        }
        
    }

}

extension RootViewModel: RickAndMortyViewModelProtocol {
    var id: Int {selectedIndex}
    
    func didSelectItem(at indexPath: IndexPath) {
        selectedIndex = self.rickAndMortyResult[indexPath.row].id
    }
    
    
    func viewDidLoad() {
        fetchAllData()
    }
    
    
}
