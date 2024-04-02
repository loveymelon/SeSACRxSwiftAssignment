//
//  ShoppingHeaderView.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 4/2/24.
//

import UIKit
import SnapKit
import Then

class ShoppingHeaderView: UITableViewHeaderFooterView {
    
    let searchTextField = UITextField().then {
        $0.backgroundColor = .systemGray5
        $0.layer.cornerRadius = 10
        $0.placeholder = "무엇을 구매하실건가요?"
        $0.isUserInteractionEnabled = true
    }
    let searchButton = UIButton().then {
        $0.setTitle("추가", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .systemGray3
        $0.layer.cornerRadius = 10
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ShoppingHeaderView {
    func configureUI() {
        configureHierarchy()
        configureLayout()
    }
    
    func configureHierarchy() {
        contentView.addSubview(searchTextField)
        contentView.addSubview(searchButton)
    }
    
    func configureLayout() {
        searchTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        
        searchButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(60)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(searchTextField.snp.trailing).inset(10)
        }
    }
}
