//
//  BirthdayViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BirthdayViewController: UIViewController {
    
    let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    
    let infoLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
    let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10 
        return stack
    }()
    
    let yearLabel: UILabel = {
       let label = UILabel()
//        label.text = "2023년"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let monthLabel: UILabel = {
       let label = UILabel()
//        label.text = "33월"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let dayLabel: UILabel = {
       let label = UILabel()
//        label.text = "99일"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let infoText = PublishSubject<String>()
    let infoColor = PublishSubject<UIColor>()
    
    // 초기값 설정이 가능한 BehaviorSubject
//    var year = BehaviorSubject(value: 2023)
//    var month = BehaviorSubject(value: 3)
//    var day = BehaviorSubject(value: 29)
    
    // 초기값 설정이 불가능한 PublishSubject
    var year = PublishSubject<Int>()
    var month = PublishSubject<Int>()
    var day = PublishSubject<Int>()
    
    let disposeBag = DisposeBag()
  
    let nextButton = PointButton(title: "가입하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configurePublish()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    @objc func nextButtonClicked() {
        print("가입완료")
    }

    
    func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
 
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
   
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        infoText.bind(to: infoLabel.rx.text)
            .disposed(by: disposeBag)
        infoColor.bind(to: infoLabel.rx.textColor)
            .disposed(by: disposeBag)
    }

    func configureBehavior() {
        
        /*
         정리
         일단 구독하기 전에 값을 넣어도 반응이 없고 구독 후부터 반응이 있다.
         하지만 BehaviorSubject는 마지막 이벤트가 구독할때 그 값이 들어가는데 그 값이 없다면 처음 세팅한 값이 들어간다.
         이러한 특징을 보면 year, month, day로 통해 레이블을 세팅해주도록하는 구독 코드 밑에 위치시켰을땐 올바르게 오늘 날짜가 나오지만
         owner.year.onNext(year)를 주석처리한 상태로 구독하기 전인 위로 올리면 처음세팅한 값이 나온다. 일단 이 예시는 올바르지 않지만
         아까 주석처리를 한 이유는 BehaviorSubject의 특징이 구독했을때  마지막으로 들어온 값으로 설정이 되기때문에 구독하기 전에 위치시켜도
         오늘 날짜가 나오기 때문에 의도적으로 주석처리를 한 것이다.
         */
        
//        birthDayPicker.rx.date.subscribe(with: self) { owner, date in
//            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
//            
//            guard let year = dateComponents.year else { return }
//            guard let month = dateComponents.month else { return }
//            guard let day = dateComponents.day else { return }
//            
//            owner.year.onNext(year)
//            owner.month.onNext(month)
//            owner.day.onNext(day)
//            
//        }.disposed(by: disposeBag)
        
//        year.map { String($0) + "년" }.bind(to: yearLabel.rx.text)
//            .disposed(by: disposeBag)
//        
//        month.map { String($0) + "월" }.bind(to: monthLabel.rx.text)
//            .disposed(by: disposeBag)
//        
//        day.map { String($0) + "일" }.bind(to: dayLabel.rx.text)
//            .disposed(by: disposeBag)
//        
//        birthDayPicker.rx.date.subscribe(with: self) { owner, date in
//            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
//            
//            guard let year = dateComponents.year else { return }
//            guard let month = dateComponents.month else { return }
//            guard let day = dateComponents.day else { return }
//            
//            owner.year.onNext(year)
//            owner.month.onNext(month)
//            owner.day.onNext(day)
//            
//        }.disposed(by: disposeBag)
        
        
    }
    
    func configurePublish() {
        
        /*
         정리
         구독하기 전에 값을 세팅하여도 해당 값들은 무시가 되므로 아무것도 나오지 않는 것이다.
         그래서 날짜를 변경을 해야 값이 나온다 -> 값 변경은 구독후에 벌어진 시간이기때문이다.
         유저에게 오늘날짜로된 값을 보여주고 싶다면 레이블의 값을 세팅해주는 구독을 먼저 해준뒤에 값을 보내주면 된다.
         */
        
        
        // 구독전 값 세팅
//        birthDayPicker.rx.date.subscribe(with: self) { owner, date in
//            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
//            
//            guard let year = dateComponents.year else { return }
//            guard let month = dateComponents.month else { return }
//            guard let day = dateComponents.day else { return }
//            
//            owner.year.onNext(year)
//            owner.month.onNext(month)
//            owner.day.onNext(day)
//            
//        }.disposed(by: disposeBag)
        
        year.map { String($0) + "년" }.bind(to: yearLabel.rx.text)
            .disposed(by: disposeBag)
        
        month.map { String($0) + "월" }.bind(to: monthLabel.rx.text)
            .disposed(by: disposeBag)
        
        day.map { String($0) + "일" }.bind(to: dayLabel.rx.text)
            .disposed(by: disposeBag)
        
        // 구독 후 세팅
        birthDayPicker.rx.date.subscribe(with: self) { owner, date in
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
            guard let birth = Calendar.current.date(from: dateComponents) else { return }
            
            let components = Calendar.current.dateComponents([.year], from: birth, to: Date())
            
            let birthAge = 17
            
            if let age = components.year, age >= birthAge {
                owner.infoText.onNext("가입 가능한 나이입니다.")
                owner.infoColor.onNext(.blue)
                owner.nextButton.backgroundColor = .blue
                owner.nextButton.isEnabled = true
            } else {
                owner.infoText.onNext("만 17세 이상만 가입 가능합니다.")
                owner.infoColor.onNext(.red)
                owner.nextButton.backgroundColor = .lightGray
                owner.nextButton.isEnabled = false
            }
            
            let todayComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
            guard let year = dateComponents.year else { return }
            guard let month = dateComponents.month else { return }
            guard let day = dateComponents.day else { return }
            
            owner.year.onNext(year)
            owner.month.onNext(month)
            owner.day.onNext(day)
            
        }.disposed(by: disposeBag)
        
        nextButton.rx.tap.bind(with: self) { owner, _ in
            let vc = SampleViewController()
            
            let nav = UINavigationController(rootViewController: vc)
            
            owner.view.window?.rootViewController = nav
        }.disposed(by: disposeBag)
    }
}
