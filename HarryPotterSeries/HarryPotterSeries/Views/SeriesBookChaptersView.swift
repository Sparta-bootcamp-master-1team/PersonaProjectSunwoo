//
//  SeriesBookChaptersView.swift
//  HarryPotterSeries
//
//  Created by 조선우 on 3/31/25.
//

import UIKit
import SnapKit

class SeriesBookChaptersView: UIView {
    private let chaptersLabel: UILabel = {
        let label = UILabel()
        label.text = "Chapters"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var chaptersInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var seriesBookChaptersStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [chaptersLabel, chaptersInfoStackView])
        stackView.axis = .vertical
        stackView.spacing = 8
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
        self.addSubview(seriesBookChaptersStackView)
        
        seriesBookChaptersStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
    
    func configure(chaptersString: [String]) {        
        for chapter in chaptersString {
            let chpLabel = UILabel()
            chpLabel.text = chapter
            chpLabel.textColor = .darkGray
            chpLabel.font = .systemFont(ofSize: 14)
            
            chaptersInfoStackView.addArrangedSubview(chpLabel)
        }
    }
}
