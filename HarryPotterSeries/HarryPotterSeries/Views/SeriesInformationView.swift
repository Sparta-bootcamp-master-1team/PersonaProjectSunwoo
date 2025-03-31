//
//  SeriesInformationView.swift
//  HarryPotterSeries
//
//  Created by 조선우 on 3/31/25.
//

import UIKit
import SnapKit

class SeriesInformationView: UIView {
    
    private let pagesLabel: UILabel = {
        let label = UILabel()
        label.text = "Pages"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let pagesInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var pagesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [pagesLabel, pagesInfoLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let releasedLabel: UILabel = {
        let label = UILabel()
        label.text = "Released"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let releasedInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        // 날짜 형식 바꾸기
        return label
    }()
    
    private lazy var releasedStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releasedLabel, releasedInfoLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let authorInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var authorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [authorLabel, authorInfoLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let seriesInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var wordsInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [seriesInfoTitleLabel, authorStackView, releasedStackView, pagesStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    private let seriesCoverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var seriesInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [seriesCoverImage, wordsInfoStackView])
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .top
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(seriesInfoStackView)
        
        seriesCoverImage.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        
        seriesInfoStackView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    func configure(coverImage: String, seriesTitle: String, authorName: String, releasedDate: String, totalPages: Int) {
        seriesCoverImage.image = UIImage(named: coverImage)
        seriesInfoTitleLabel.text = seriesTitle
        authorInfoLabel.text = authorName
        releasedInfoLabel.text = releasedDate
        pagesInfoLabel.text = "\(totalPages)"
    }
}
