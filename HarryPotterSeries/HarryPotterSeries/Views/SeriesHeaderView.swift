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
        stackView.spacing = 10
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
    
    // 현재 선택된 버튼의 인덱스 (초기값은 첫번째)
    private var selectedIndex: Int = 0
    
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
            $0.top.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    @objc private func seriesButtonTapped (_ sender: UIButton) {
        // 선택된 인덱스 업데이트
        selectedIndex = sender.tag
        // delegate 호출
        delegate?.didSelectSeries(sender.tag)
    }
    
    // 버튼의 상태를 업데이트
    func updateButtonSelection(selectedIndex: Int) {
        seriesButtonStackView.arrangedSubviews.enumerated().forEach { index, view in
            guard let button = view as? UIButton else { return }
            let isSelected = index == selectedIndex
            button.backgroundColor = isSelected ? .systemBlue : .lightGray
            button.setTitleColor(isSelected ? .white : .darkGray, for: .normal)
        }
    }
    
    func configure(seriesTitle: String, seriesNumber: Int) {
        seriesTitleLabel.text = seriesTitle
        
        // 기존 버튼을 초기화 (삭제)
        seriesButtonStackView.arrangedSubviews.forEach {  $0.removeFromSuperview() }
        
        // 버튼의 0부터 7의 시리즈 값을 반복문으로 처리
        for number in 0..<seriesNumber {
            let button = UIButton()
            button.tag = number
            button.setTitle("\(number + 1)", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16)
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
            button.backgroundColor = number == selectedIndex ? .systemBlue : .lightGray
            button.setTitleColor(number == selectedIndex ? .white : .darkGray, for: .normal)
            button.addTarget(self, action: #selector(seriesButtonTapped), for: .touchUpInside)
            
            seriesButtonStackView.addArrangedSubview(button)
        }
    }
    
}
