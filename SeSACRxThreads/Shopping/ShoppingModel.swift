//
//  ShoppingModel.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 4/1/24.
//

import Foundation
import RxDataSources

struct CustomData {
    var itemText: String
    var checkBool: Bool
    var starBool: Bool
} // cell 데이터

struct SectionOfCustomData {
  var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = CustomData // cell 데이터
    
    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
