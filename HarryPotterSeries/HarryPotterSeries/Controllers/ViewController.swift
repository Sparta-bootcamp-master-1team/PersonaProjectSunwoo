//
//  ViewController.swift
//  HarryPotterSeries
//
//  Created by 조선우 on 3/28/25.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    private let dataService = DataService()
    private let seriesHeaderView = SeriesHeaderView()
    private let seriesInformationView = SeriesInformationView()
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                guard let firstBook = books.first else { return }
                DispatchQueue.main.async {
                    self.seriesHeaderView.configure(seriesTitle: firstBook.title, seriesNumber: 1)
                    self.seriesInformationView.configure(coverImage: "harrypotter1", seriesTitle: firstBook.title, authorName: firstBook.author, releasedDate: firstBook.releaseDate, totalPages: firstBook.pages)
                }
                
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBooks()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        [seriesHeaderView, seriesInformationView].forEach { view.addSubview($0) }
        
        seriesHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        seriesInformationView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(5)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-5)
            $0.top.equalTo(seriesHeaderView.snp.bottom).offset(10)
        }
    }
}

