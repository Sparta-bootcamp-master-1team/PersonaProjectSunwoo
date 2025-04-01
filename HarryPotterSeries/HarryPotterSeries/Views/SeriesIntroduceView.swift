//
//  SeriesIntroduceView.swift
//  HarryPotterSeries
//
//  Created by 조선우 on 3/31/25.
//

import UIKit
import SnapKit

class SeriesIntroduceView: UIView {
    // Dedication
    private let dedicationLabel: UILabel = {
        let label = UILabel()
        label.text = "Dedication"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let dedicationInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dedicationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dedicationLabel, dedicationInfoLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    // Summary
    private let summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let summaryInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var summaryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [summaryLabel, summaryInfoLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    // Dedication + Summary StackView
    private lazy var seriesIntroduceStackView = {
        let stackView = UIStackView(arrangedSubviews: [dedicationStackView, summaryStackView])
        stackView.axis = .vertical
        stackView.spacing = 24
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
        self.addSubview(seriesIntroduceStackView)
        
        seriesIntroduceStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
    
    func configure(dedicationString: String, summaryString: String) {
        dedicationInfoLabel.text = dedicationString
        summaryInfoLabel.text = summaryString
    }
}
