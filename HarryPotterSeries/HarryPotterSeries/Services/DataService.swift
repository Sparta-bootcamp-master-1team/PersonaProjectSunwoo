//
//  DataService.swift
//  HarryPotterSeries
//
//  Created by 조선우 on 3/28/25.
//


import Foundation

class DataService {
    
    enum DataError: Error {
        case fileNotFound
        case parsingFailed
    }
    
    func loadBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        // 에러처리 확인을 위한 잘못된 경로 설정
//        let forceError = true
//        
//        if forceError {
//            completion(.failure(DataError.fileNotFound))
//            return
//        }
        
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            completion(.failure(DataError.fileNotFound))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data)
            let books = bookResponse.data.map { $0.attributes }
            completion(.success(books))
        } catch {
            print("🚨 JSON 파싱 에러 : \(error)")
            completion(.failure(DataError.parsingFailed))
        }
    }
}


 
