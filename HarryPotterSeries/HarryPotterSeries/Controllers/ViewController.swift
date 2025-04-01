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
    private let seriesBookChaptersView = SeriesBookChaptersView()
    
    private let seriesScollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let books): // 우선 시리즈 1
                    guard let firstBook = books.first else { return }
                    let chapterTitles = firstBook.chapters.map { $0.title }
                    
                    self.seriesHeaderView.configure(seriesTitle: firstBook.title, seriesNumber: 1)
                    self.seriesInformationView.configure(coverImage: "harrypotter1", seriesTitle: firstBook.title, authorName: firstBook.author, releasedDate: firstBook.releaseDate, totalPages: firstBook.pages)
                    self.seriesIntroduceView.configure(dedicationString: firstBook.dedication, summaryString: firstBook.summary)
                    self.seriesBookChaptersView.configure(chaptersString: chapterTitles)
                    
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
        view.backgroundColor = .white
        loadBooks()
        setupUI()
    }
    
    private func setupUI() {
        [seriesHeaderView, seriesScollView].forEach{ view.addSubview($0) }
        seriesScollView.addSubview(contentView)
        [seriesInformationView, seriesIntroduceView, seriesBookChaptersView].forEach { contentView.addSubview($0) }
        
        seriesHeaderView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        seriesScollView.snp.makeConstraints {
            $0.top.equalTo(seriesHeaderView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(seriesScollView.snp.width)
            $0.top.bottom.equalToSuperview()
        }
        
        seriesInformationView.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            $0.top.equalToSuperview().offset(10)
        }
        
        seriesIntroduceView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(seriesInformationView.snp.bottom).offset(24)
        }
        
        seriesBookChaptersView.snp.makeConstraints {
            $0.top.equalTo(seriesIntroduceView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
    }
}

