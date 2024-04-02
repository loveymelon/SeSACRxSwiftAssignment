//
//  DetailViewController.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 4/2/24.
//

import UIKit
import RxSwift
import RxCocoa
import Then

class DetailViewController: BaseViewController<DetailView> {

    var shoppingModel: CustomData?
    let backButton = UIButton().then {
        $0.setTitle("dddd", for: .normal)
    }
    
    lazy var datas = BehaviorSubject(value: shoppingModel)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func configureNav() {
        self.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    override func bind() {
        datas.bind(with: self) { owner, data in
            guard let modelData = data else { return }
            
            owner.mainView.checkBox.isSelected = modelData.checkBool
            owner.mainView.itemTextField.text = modelData.itemText
            owner.mainView.starBox.isSelected = modelData.starBool
            
        }.disposed(by: disposeBag)
        
        mainView.checkBox.rx.tap.bind(with: self) { owner, _ in
            guard var modelData = owner.shoppingModel else  { return }
            owner.mainView.checkBox.isSelected.toggle()
            modelData.checkBool.toggle()
            
            owner.datas.onNext(modelData)
        }.disposed(by: disposeBag)
        
        mainView.starBox.rx.tap.bind(with: self) { owner, _ in
            guard var modelData = owner.shoppingModel else  { return }
            owner.mainView.starBox.isSelected.toggle()
            
            owner.datas.onNext(modelData)
        }.disposed(by: disposeBag)
        
        backButton.rx.tap.bind(with: self) { owner, _ in
            owner.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
    }

}
