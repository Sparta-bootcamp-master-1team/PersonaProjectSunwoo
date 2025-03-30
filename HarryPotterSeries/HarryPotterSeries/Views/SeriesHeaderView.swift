//
//  SeriesHeaderView.swift
//  HarryPotterSeries
//
//  Created by 조선우 on 3/30/25.
//

import UIKit
import SnapKit

class SeriesHeaderView: UIView {
    private let seriesTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [seriesTitleLabel, seriesNumberButton].forEach { self.addSubview($0) }
        
        seriesTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        seriesNumberButton.snp.makeConstraints {
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.top.equalTo(seriesTitleLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    func configure(seriesTitle: String, seriesNumber: Int) {
        seriesTitleLabel.text = seriesTitle
        seriesNumberButton.setTitle("\(seriesNumber)", for: .normal)
    }

}
