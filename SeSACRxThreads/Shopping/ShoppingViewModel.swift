//
//  ShoppingViewModel.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 4/3/24.
//

import Foundation
import RxSwift
import RxCocoa

class ShoppingViewModel {
    var dummy = [ CustomData(itemText: "fdfd"), CustomData(itemText: "fdfdf"), CustomData(itemText: ""), CustomData(itemText: "fdfdf") ]
    
    var filter: [CustomData] = []
    
    lazy var outputItems = BehaviorRelay(value: dummy)
    let outputSearchText = PublishRelay<String>()
    
    var inputSearchText = PublishSubject<String>()
    var inputChangeSearchText = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    
    init() {
        bind()
    }
    
    private func bind() {
        inputSearchText.subscribe(with: self) { owner, text in
            owner.dummy.append(CustomData(itemText: text))
            
            owner.outputItems.accept(owner.dummy)
            
            owner.outputSearchText.accept("")
            owner.inputSearchText
                .subscribe(owner.inputChangeSearchText)
                .disposed(by: owner.disposeBag)
            
        }.disposed(by: disposeBag)
        
        inputChangeSearchText.subscribe(with: self) { owner, text in
            guard !text.isEmpty else {
                owner.outputItems.accept(owner.dummy)
                return
            }
            owner.filter.append(contentsOf: owner.dummy.filter { $0.itemText.contains(text) })
            owner.outputItems.accept(owner.filter)
        }.disposed(by: disposeBag)
    }
}
