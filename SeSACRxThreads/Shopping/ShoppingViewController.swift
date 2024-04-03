//
//  ShoppingViewController.swift
//  SeSACRxThreads
//
//  Created by 김진수 on 4/1/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxGesture

class ShoppingViewController: BaseViewController<ShoppingView> {
    
//    var dummy = [
//        SectionOfCustomData(items: [CustomData(itemText: "dkdkdk", checkImage: "checkmark.square", starImage: "star"), CustomData(itemText: "dkdkdk", checkImage: "checkmark.square", starImage: "star"), CustomData(itemText: "dkdkdk", checkImage: "checkmark.square", starImage: "star")])
//    ]
    
//    lazy var section = BehaviorSubject(value: sections)
    
    let shoppingViewModel = ShoppingViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bind() {
        shoppingViewModel
            .outputItems
            .asDriver(onErrorJustReturn: [])
            .drive(mainView.tableView.rx.items(cellIdentifier: ShoppingTableViewCell.identifier, cellType: ShoppingTableViewCell.self)) { indexPath, item, cell in
                
                cell.itemTitle.text = item.itemText
                cell.checkButton.isSelected = item.checkBool
                cell.starButton.isSelected = item.starBool
                
                cell.checkButton.rx.tap.bind(with: self) { owner, _ in
                    owner.shoppingViewModel.dummy[indexPath].checkBool.toggle()
                    owner.shoppingViewModel.outputItems.accept(owner.shoppingViewModel.dummy)
                    cell.checkButton.isSelected.toggle()
                }.disposed(by: cell.disposeBag)
                
                cell.starButton.rx.tap.bind(with: self) { owner, _ in
                    owner.shoppingViewModel.dummy[indexPath].starBool.toggle()
                    owner.shoppingViewModel.outputItems.accept(owner.shoppingViewModel.dummy)
                    cell.starButton.isSelected.toggle()
                }.disposed(by: cell.disposeBag)

            }.disposed(by: disposeBag)
        
        mainView.searchButton
            .rx
            .tap
            .withLatestFrom(mainView.searchTextField.rx.text.orEmpty)
            .subscribe(shoppingViewModel.inputSearchText)
            .disposed(by: disposeBag)
        
        shoppingViewModel.outputSearchText
            .asDriver(onErrorJustReturn: "")
            .drive(mainView.searchTextField.rx.text)
            .disposed(by: disposeBag)
        
        
        
        mainView.tableView
            .rx
            .itemSelected
            .bind(with: self) { owner, indexPath in
            print("taaap")
            let vc = DetailViewController()
            vc.shoppingModel = owner.shoppingViewModel.dummy[indexPath.row]
            
            vc.datas.subscribe(with: self) { owner, data in
                guard let datas = data else { return }
                owner.shoppingViewModel.outputItems.accept([datas])
            }.disposed(by: self.disposeBag)
            
            owner.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
        
        mainView.searchTextField
            .rx
            .text
            .orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(shoppingViewModel.inputChangeSearchText)
            .disposed(by: disposeBag)
        
//        mainView.tableView
//            .rx.setDelegate(self)
//            .disposed(by: disposeBag)
//        
//        var dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData> { dataSource, tableView, indexPath, item in
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingTableViewCell.identifier, for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell() }
//            
//            cell.checkButton.configuration?.image = UIImage(systemName: item.checkImage)
//            cell.itemTitle.text = item.itemText
//            cell.starButton.configuration?.image = UIImage(systemName: item.starImage)
//            
//            return cell
//        }
//        
//        dataSource.canEditRowAtIndexPath = {dataSource, indexPath in true}
//        
//        section.bind(to: mainView.tableView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
//        
//        mainView.rx.tapGesture().when(.recognized).bind(with: self) { owner, _ in
//            owner.mainView.endEditing(true)
//        }.disposed(by: disposeBag)
//        
//        mainView.tableView.rx.itemDeleted.bind(with: self) { owner, indexPath in
//            var updateSection = owner.sections[indexPath.section]
//            
//            updateSection.items.remove(at: indexPath.row)
//            
//            owner.section.onNext([updateSection])
//            
//            print(owner.sections)
//        }.disposed(by: disposeBag)
        
//        mainView.rx.tapGesture().when(.recognized).bind(with: self) { owner, _ in
//            owner.mainView.endEditing(true)
//        }.disposed(by: disposeBag)
        
//        mainView.searchTextField.rx.controlEvent(.valueChanged).withLatestFrom(mainView.searchTextField.rx.text.orEmpty).subscribe(with: self) { owner, text in
//            print(text)
//            owner.filter.append(contentsOf: owner.dummy.filter { $0.itemText.contains(text) })
//            owner.items.onNext(owner.filter)
//        }.disposed(by: disposeBag)
        
    }
    
}

//extension ShoppingViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard section == 0 else { return nil }
//        
//        let headerView = ShoppingHeaderView()
//        
//        headerView.searchButton.rx.tap.subscribe(with: self) { owner, _ in
//            
//            guard let text = headerView.searchTextField.text else { return }
//            
//            owner.sections[0].items.append(CustomData(itemText: text, checkImage: "checkmark.square", starImage: "star"))
//            
//            owner.section.onNext(owner.sections)
//            
//        }.disposed(by: disposeBag)
//        
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 120
//    }
//}
