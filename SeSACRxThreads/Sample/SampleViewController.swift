//
//  SampleViewController.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 3/31/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SampleViewController: UIViewController {
    
    let addButton: UIButton = {
        var config = UIButton.Configuration.filled()
        
        config.title = "추가"
        
        let button = UIButton(configuration: config)
        
        return button
    }()
    let sampleTableView = UITableView()
    let sampleTextField: UITextField = {
        let textField = UITextField()
        
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        
        return textField
    }()
    
    let textFieldText = BehaviorSubject(value: "추가하실 값을 입력해주세요.")
    
    var tableText = BehaviorRelay(value: [String]())
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
        bind()
    }
    
    func configureLayout() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(sampleTextField)
        self.view.addSubview(sampleTableView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        
        sampleTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        sampleTextField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(30)
        }
        
        sampleTableView.snp.makeConstraints { make in
            make.top.equalTo(sampleTextField.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

    func bind() {
        textFieldText.bind(to: sampleTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        addButton.rx.tap.bind(with: self, onNext: { owner, _ in
            guard let text = owner.sampleTextField.text else { return }
            
            owner.tableText.accept(owner.tableText.value + [text])
            owner.sampleTextField.text = ""
            
        }).disposed(by: disposeBag)
        
        tableText.bind(to: sampleTableView.rx.items) { tableView, index, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else { return UITableViewCell() }
            
            cell.textLabel?.text = item
            
            return cell
        }.disposed(by: disposeBag)
        
        Observable.zip(sampleTableView.rx.itemSelected, sampleTableView.rx.modelSelected(String.self))
            .bind(with: self) { owner, item in
                var tempArray = owner.tableText.value
                
                tempArray.remove(at: item.0.row)
                
                owner.tableText.accept(tempArray)
                
            }.disposed(by: disposeBag)
    }
}
