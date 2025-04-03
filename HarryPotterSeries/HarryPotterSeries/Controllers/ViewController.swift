//
//  ViewController.swift
//  HarryPotterSeries
//
//  Created by 조선우 on 3/28/25.
//

import UIKit
import SnapKit


class ViewController: UIViewController {
    private var books = [Book]()
    private var currentBookIndex = 0
    
    private let dataService = DataService()
    private let seriesHeaderView = SeriesHeaderView()
    private let seriesInformationView = SeriesInformationView()
    private let seriesIntroduceView = SeriesIntroduceView()
    private let seriesBookChaptersView = SeriesBookChaptersView()
    
    // ScrollView
    private let seriesScollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // ScrollView를 사용하기 위한 contentView
    private let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        seriesHeaderView.delegate = self
        loadBooks()
        setupUI()
    }
    
    private func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let books):
                    self.books = books.sorted(by: { $0.releaseDate < $1.releaseDate })
                    self.setupInitialUI()
                    
                case .failure(let error):
                    self.showErrorAlert(error: error)
                }
            }
        }
    }
    
    // 0번째인 초기값 설정
    private func setupInitialUI() {
        guard !books.isEmpty else { return }
        updateUI(index: 0)
    }
    
    // configure를 모아놓은 함수
    private func updateUI(index: Int) {
        let book = books[index]
        
        // seriesHeaderView의 버튼 선택 상태를 업데이트함
        seriesHeaderView.updateButtonSelection(selectedIndex: index)
        
        seriesHeaderView.configure(seriesTitle: book.title, seriesNumber: books.count)
        seriesInformationView.configure(coverImage: "harrypotter\(index + 1)", seriesTitle: book.title, authorName: book.author, releasedDate: book.releaseDate, totalPages: book.pages)
        seriesIntroduceView.configure(dedicationString: book.dedication, summaryString: book.summary, bookIndex: index)
        seriesBookChaptersView.configure(chaptersString: book.chapters.map { $0.title })
    }
    
    private func showErrorAlert(error: Error) {
        // alert창으로 에러처리 구현
        let alert = UIAlertController(title: "Error", message: "데이터를 불러오지 못했습니다🚨: \(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
    
    private func setupUI() {
        // ScrollView 안에 contentView(UIView) 안에 subViews 구조
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
            $0.leading.trailing.equalToSuperview()
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

extension ViewController: SeriesHeaderDelegate {
    func didSelectSeries(_ index: Int) {
        currentBookIndex = index
        updateUI(index: index)
    }
}
