//
//  SignUpViewModel.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 4/3/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SignUpViewModel {
    var outputCheckBool = PublishRelay<Bool>()
    
    var inputEmailText = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    
    init() {
        bind()
    }
    
    private func bind() {
        inputEmailText
            .map { $0.count >= 8 }
//            .subscribe(outputCheckBool) 이게 왜 안되는지 모르겠다.
            .subscribe(with: self) { owner, bool in
                owner.outputCheckBool.accept(bool)
            }.disposed(by: disposeBag)
    }
}
