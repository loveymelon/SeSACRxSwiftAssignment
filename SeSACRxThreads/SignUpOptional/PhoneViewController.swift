//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneViewController: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let descriptionLabel = UILabel()
    
    let basicPhoneText = BehaviorSubject(value: "010")
    let validText = Observable.just("10자 이상 입력해주세요")
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configureUI()
    }

    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(nextButton)
         
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(phoneTextField.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

    func configureUI() {
        basicPhoneText.bind(to: phoneTextField.rx.text).disposed(by: disposeBag)
        validText.bind(to: descriptionLabel.rx.text).disposed(by: disposeBag)
        
        phoneTextField.rx.text.orEmpty.map { $0.count >= 10 && Int($0) != nil }.bind(to: nextButton.rx.isEnabled, descriptionLabel.rx.isHidden).disposed(by: disposeBag)
        
        phoneTextField.rx.text.orEmpty.map { $0.count >= 10 && Int($0) != nil }
            .bind(with: self) { owner, bool in
                
                owner.nextButton.isEnabled = bool
                owner.descriptionLabel.isHidden = bool
                owner.nextButton.backgroundColor = bool ? .systemPink : .lightGray
                
            }.disposed(by: disposeBag)
        
        nextButton.rx.tap.bind(with: self) { owner, _ in
            owner.navigationController?.pushViewController(NicknameViewController(), animated: true)
        }.disposed(by: disposeBag)
    }
    
}
