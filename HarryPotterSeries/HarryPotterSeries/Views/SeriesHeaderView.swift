//
//  SeriesHeaderView.swift
//  HarryPotterSeries
//
//  Created by 조선우 on 3/30/25.
//

import UIKit
import SnapKit

protocol SeriesHeaderDelegate: AnyObject {
    func didSelectSeries(_ index: Int)
}

class SeriesHeaderView: UIView {
    weak var delegate: SeriesHeaderDelegate?
    
    private let seriesTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // seriesButton을 stackView로 묶음
    private lazy var seriesButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    // seriesTitle, seriesHeaderStackView를 stackView로 묶음
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
    
    @objc private func seriesButtonTapped (_ sender: UIButton) {
        delegate?.didSelectSeries(sender.tag)
    }
    
    func configure(seriesTitle: String, seriesNumber: Int) {
        seriesTitleLabel.text = seriesTitle
        
        // 버튼의 0부터 7의 시리즈 값을 반복문으로 처리
        for number in 0..<seriesNumber {
            let numberButton = UIButton()
            numberButton.tag = number
            numberButton.setTitle("\(number + 1)", for: .normal)
            numberButton.titleLabel?.font = .systemFont(ofSize: 16)
            numberButton.layer.cornerRadius = 15
            numberButton.clipsToBounds = true
            numberButton.backgroundColor = number == 0 ? .systemBlue : .lightGray
            numberButton.setTitleColor(number == 0 ? .white : .darkGray, for: .normal)
            numberButton.addTarget(self, action: #selector(seriesButtonTapped), for: .touchUpInside)
            
            seriesButtonStackView.addArrangedSubview(numberButton)
        }
    }

}
