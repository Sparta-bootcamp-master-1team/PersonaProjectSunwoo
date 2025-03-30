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
    private var successBooks: [Book] = []
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                self.successBooks = books
                
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    private let seriesTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    func configure() {
        seriesTitleLabel.text = "\(successBooks[0].title)"
    }
    
    private let seriesNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("1", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadBooks()
        configure()
        makeUI()
    }
    
    private func makeUI() {
        
        [seriesTitleLabel, seriesNumberButton].forEach { view.addSubview($0) }
        
        seriesTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        seriesNumberButton.snp.makeConstraints {
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.top.equalTo(seriesTitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
}

