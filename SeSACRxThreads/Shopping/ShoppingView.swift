//
//  ShoppingView.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 4/1/24.
//

import UIKit
import SnapKit
import Then

class ShoppingView: BaseView {
    
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
    
    let tableView = UITableView().then {
        $0.register(ShoppingTableViewCell.self, forCellReuseIdentifier: ShoppingTableViewCell.identifier)
        $0.rowHeight = 70
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubview(searchTextField)
        addSubview(searchButton)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        searchTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(70)
        }
        
        searchButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(60)
            make.centerY.equalTo(searchTextField.snp.centerY)
            make.trailing.equalTo(searchTextField.snp.trailing).inset(10)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(5)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
