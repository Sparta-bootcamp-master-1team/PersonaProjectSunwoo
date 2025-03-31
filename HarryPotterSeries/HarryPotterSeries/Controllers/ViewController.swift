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
    private let seriesIntroduceView = SeriesIntroduceView()
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let books): // 우선 시리즈 1
                    guard let firstBook = books.first else { return }
                    
                    self.seriesHeaderView.configure(seriesTitle: firstBook.title, seriesNumber: 1)
                    self.seriesInformationView.configure(coverImage: "harrypotter1", seriesTitle: firstBook.title, authorName: firstBook.author, releasedDate: firstBook.releaseDate, totalPages: firstBook.pages)
                    self.seriesIntroduceView.configure(dedicationString: firstBook.dedication, summaryString: firstBook.summary)
                    
                case .failure(let error):
                    // alert창으로 에러처리 구현
                    let alert = UIAlertController(title: "Error", message: "데이터를 불러오지 못했습니다: \(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(alert, animated: true)
                }
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
        
        [seriesHeaderView, seriesInformationView, seriesIntroduceView].forEach { view.addSubview($0) }
        
        seriesHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        seriesInformationView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.top.equalTo(seriesHeaderView.snp.bottom).offset(10)
        }
        
        seriesIntroduceView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(seriesInformationView.snp.bottom).offset(24)
        }
    }
}

