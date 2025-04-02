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
    
    private lazy var seriesButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var seriesHeaderStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [seriesTitleLabel, seriesButtonStackView])
        stackView.axis = .vertical
        stackView.spacing = 16
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
        self.addSubview(seriesHeaderStackView)
        
        seriesHeaderStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func configure(seriesTitle: String, seriesNumber: Int) {
        seriesTitleLabel.text = seriesTitle
        
        for number in 0..<seriesNumber {
            let numberButton = UIButton()
            numberButton.setTitle("\(number + 1)", for: .normal)
            numberButton.titleLabel?.font = .systemFont(ofSize: 16)
            numberButton.layer.cornerRadius = 15
            numberButton.clipsToBounds = true
            numberButton.backgroundColor = number == 0 ? .systemBlue : .lightGray
            numberButton.setTitleColor(number == 0 ? .white : .darkGray, for: .normal)
            
            seriesButtonStackView.addArrangedSubview(numberButton)
        }
    }

}
