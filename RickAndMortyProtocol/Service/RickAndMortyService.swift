//
//  RickAndMortyService.swift
//  RickAndMortyProtocol
//
//  Created by Kerem on 5.03.2023.
//

import Foundation

protocol RickAndMortyServiceProtocol {
    //func getDataAPI<T: Decodable>(request: URLRequest, completion: @escaping ((Result<T, RickAndMortyError>) -> Void))
    func fetchAllData(page: Int, completion: @escaping ((Result<ApiResult, RickAndMortyError>) -> Void))
    func fetchDetailData(id: Int, completion: @escaping ((Result<Detail, RickAndMortyError>) -> Void))
}

class RickAndMortyService: RickAndMortyServiceProtocol {
    func getDataAPI<T>(request: URLRequest, completion: @escaping ((Result<T, RickAndMortyError>) -> Void)) where T: Decodable {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    if let HTTPresponse = response as? HTTPURLResponse {
                        switch HTTPresponse.statusCode {
                        case 200:
                            do {
                                let result = try JSONDecoder().decode(T.self, from: data)
                                completion(.success(result))
                            } catch (let error) {
                                print(error)
                                completion(.failure(RickAndMortyError(statusMessage: "Error", statusCode: 200)))
                            }
                        case 400, 401:
                            do {
                                let error = try JSONDecoder().decode(RickAndMortyError.self, from: data)
                                completion(.failure(error))
                            } catch (let error) {
                                print(error)
                                completion(.failure(RickAndMortyError(statusMessage: "Something went Wrong!", statusCode: HTTPresponse.statusCode)))
                            }
                        default:
                            completion(.failure(RickAndMortyError(statusMessage: "Error response code", statusCode: HTTPresponse.statusCode)))
                        }
                    }
                }
            }
        }.resume()
    }



}

extension RickAndMortyService {

    func fetchAllData(page: Int, completion: @escaping ((Result<ApiResult, RickAndMortyError>) -> Void)) {
        let request = getAllDataURL(page)
        getDataAPI(request: request, completion: completion)
    }
    func fetchDetailData(id: Int, completion: @escaping ((Result<Detail, RickAndMortyError>) -> Void)) {
        let request = getDetailURL(for: id)
        getDataAPI(request: request, completion: completion)
    }
}

extension RickAndMortyService {

    func getAllDataURL(_ page: Int) -> URLRequest {
        let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }

    func getDetailURL(for id: Int) -> URLRequest {
        let url = URL(string: "https://rickandmortyapi.com/api/character/\(id)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }

}



struct RickAndMortyError: Codable, Error, LocalizedError {

    var statusMessage: String
    var statusCode: Int

    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_mesage"
        case statusCode = "status_code"
    }

    var localizedDescription: String {
        return statusMessage
    }

}
