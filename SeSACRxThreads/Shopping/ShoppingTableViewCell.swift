//
//  ShoppingTableViewCell.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 4/1/24.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

class ShoppingTableViewCell: UITableViewCell {
    
    static let identifier = "ShoppingTableCell"
    
    let backView = UIView().then {
        $0.backgroundColor = .systemGray5
        $0.layer.cornerRadius = 10
        $0.isUserInteractionEnabled = true
    }
    
    let checkButton = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
    }
    let itemTitle = UILabel()
    let starButton = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "star"), for: .normal)
        $0.setImage(UIImage(systemName: "star.fill"), for: .selected)
    }
    
    var disposeBag = DisposeBag()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
}

extension ShoppingTableViewCell {
    func configureUI() {
        configureHierarchy()
        configureLayout()
        bind()
    }
    
    func configureHierarchy() {
        contentView.addSubview(backView)
        backView.addSubview(checkButton)
        backView.addSubview(itemTitle)
        backView.addSubview(starButton)
    }
    
    func configureLayout() {
        backView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.verticalEdges.equalTo(self.safeAreaLayoutGuide).inset(1)
        }
        
        checkButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalTo(backView.snp.leading).inset(10)
        }
        
        itemTitle.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
        }
        
        starButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(backView.snp.trailing).inset(10)
        }
    }
    
    func bind() {
        
        
//        checkButton.rx.tap
//            .withUnretained(self)
//            .map { owner, _ in owner.checkButton.isSelected }
//            .map { $0 ? "checkmark.square.fill" : "checkmark.square" }
//            .compactMap { UIImage(systemName: $0) }
//            .bind(to: checkButton.rx.configuration.im)
        
    }
}
