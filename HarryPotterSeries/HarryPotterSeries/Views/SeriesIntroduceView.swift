//
//  SeriesIntroduceView.swift
//  HarryPotterSeries
//
//  Created by 조선우 on 3/31/25.
//

import UIKit
import SnapKit

// 상태 관리 구조체 
struct ExpansionState {
    static func isExpanded(index: Int) -> Bool {
        UserDefaults.standard.bool(forKey: "series\(index)")
    }
    
    static func setExpanded(value: Bool, index: Int) {
        UserDefaults.standard.set(value, forKey: "series\(index)")
    }
}

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
    
    // toggleButton
    private let toggleButton: UIButton = {
        let button = UIButton()
        button.setTitle("더 보기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.isHidden = true
        return button
    }()
    
    private var bookIndex: Int = 0
    
    // 펼쳐진 or 접힌 상태인지 값 저장
    private var isExpanded: Bool = false {
        didSet {
            // isExpanded의 상태를 저장하기 위함
            ExpansionState.setExpanded(value: isExpanded, index: bookIndex)
            updateSummaryText()
        }
    }
    
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
        
        // 저장된 상태를 불러옴
        isExpanded = UserDefaults.standard.bool(forKey: "SummaryExpandedState")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [seriesIntroduceStackView, toggleButton].forEach {
            self.addSubview($0)
        }
        
        seriesIntroduceStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        toggleButton.snp.makeConstraints {
            $0.top.equalTo(summaryStackView.snp.bottom)
            $0.trailing.bottom.equalToSuperview()
        }
        
        toggleButton.addTarget(self, action: #selector(toggleSummary), for: .touchUpInside)
    }
    
    // summaryInfoLabel의 원본 저장
    private var originalSummaryText: String = ""
    
    // summary가 펼쳐진 or 접힌 상태인지
    @objc private func toggleSummary() {
        isExpanded.toggle()
    }
    
    private func updateSummaryText() {
        if originalSummaryText.count > 450 {
            if isExpanded { // 펼쳐진 상태
                summaryInfoLabel.text = originalSummaryText
                toggleButton.setTitle("접기", for: .normal)
            } else { // 접힌 상태
                let reduceSummaryText = String(originalSummaryText.prefix(450)) + "..."
                summaryInfoLabel.text = reduceSummaryText
                toggleButton.setTitle("더 보기", for: .normal)
            }
        } else { // 450자 이하일 경우
            summaryInfoLabel.text = originalSummaryText
            toggleButton.isHidden = true
        }
    }
    
    func configure(dedicationString: String, summaryString: String, bookIndex: Int) {
        dedicationInfoLabel.text = dedicationString
        originalSummaryText = summaryString
        
        self.bookIndex = bookIndex
        isExpanded = ExpansionState.isExpanded(index: bookIndex) // 저장된 상태
        
        // 글자 수에 따라 toggleButton 표시 유무
        toggleButton.isHidden = summaryString.count <= 450
        updateSummaryText()
    }
}
