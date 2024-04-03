//
//  PasswordViewModel.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 4/4/24.
//

import Foundation
import RxSwift
import RxCocoa

class PasswordViewModel {
    let outputcheckBool = PublishRelay<Bool>()
    
    let inputPasswordText = PublishSubject<String>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        bind()
    }
    
    private func bind() {
        inputPasswordText
            .map { $0.count >= 8 }
            .bind(to: outputcheckBool)
            .disposed(by: disposeBag)
    }
}
