//
//  DetailView.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 4/2/24.
//

import UIKit
import SnapKit
import Then

class DetailView: BaseView {
    
    let checkBox = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
    }
    let itemTextField = UITextField().then {
        $0.textAlignment = .center
    }
    let starBox = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIImage(systemName: "star"), for: .normal)
        $0.setImage(UIImage(systemName: "star.fill"), for: .selected)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubview(checkBox)
        addSubview(itemTextField)
        addSubview(starBox)
    }
    
    override func configureLayout() {
        checkBox.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).inset(10)
            make.centerY.equalToSuperview()
        }
        
        itemTextField.snp.makeConstraints { make in
            make.leading.equalTo(checkBox.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        starBox.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(10)
            make.centerY.equalToSuperview()
        }
    }
    
}
