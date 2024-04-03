//
//  PhoneViewModel.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 4/4/24.
//

import Foundation
import RxSwift
import RxCocoa

final class PhoneViewModel {
    
    let outputCheckBool = PublishRelay<Bool>()
    
    let inputPhoneText = PublishSubject<String>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        bind()
    }
    
    private func bind() {
        inputPhoneText
            .map { $0.count >= 10 && Int($0) != nil }
            .withUnretained(self)
            .subscribe { owner, bool in
                owner.outputCheckBool.accept(bool)
            }.disposed(by: disposeBag)
    }
}
