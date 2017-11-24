//
//  FirstViewController.swift
//  RXSwiftTest
//
//  Created by 黄世光 on 2017/11/23.
//  Copyright © 2017年 黄世光. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
class FirstViewController: UIViewController {
    var disposeBag = DisposeBag()
    var textfield = UITextField()
    var button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rxCocoaTest()
//        mapTest3()
//        flatMapTest()
//        flatMapTest1()
//        filterTest2
        filterTest3()
        button.backgroundColor = UIColor.black
        button.setTitle("dismisss", for: UIControlState.normal)
        self.view.addSubview(button)
        self.view.addSubview(textfield)
        textfield.backgroundColor = UIColor.yellow
        self.view.backgroundColor = UIColor.white
        button.snp.makeConstraints ({ (make) in
            make.top.equalTo(300)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        })
        textfield.snp.makeConstraints ({ (make) in
            make.top.equalTo(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        })
    }
    func rxCocoaTest() -> Void {
        let observable = button.rx.tap.asObservable()
        
        observable.subscribe(onNext: { (result) in
            print("button点击")
            self.dismiss(animated: true, completion: nil)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
    }
    
    func mapTest() -> Void {
        Observable.of(1,2,3).map{ (result) -> AnyObject in
            if(result>2){
                return result as AnyObject
            }else{
                return "" as AnyObject
            }
        }.asObservable().subscribe(onNext: { (result) in
                print(result)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    func mapTest1() -> Void {
        Observable.of(1, 2, 3).map { "\($0)\($0)"}.asObservable().subscribe(onNext: { (result) in
            print(result)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    func mapTest3() -> Void {
        textfield.rx.text.asObservable().map { (result) -> String in
            let str = result! as NSString
            if str.length > 11{
                return str.substring(to: 11) as String
            }else{
                return str as String
            }
        }.asObservable().subscribe(onNext: {[unowned self] (result) in
                print(result)
            self.textfield.text = result
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    func flatMapTest() -> Void {
        let sequenceInt = Observable.of(1, 2, 3)
        let sequenceString = Observable.of("A", "B", "C", "D")
        
        sequenceInt.flatMap { _ in
            return sequenceString
            }
        .subscribe(onNext: { (result) in
            print(result)
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    
    }
    func flatMapTest1() -> Void {
        let first = BehaviorSubject(value: "👦🏻")
        let second = BehaviorSubject(value: "🅰️")
        let variable = Variable(first)
        
        variable.asObservable()
            .flatMap { $0 }
        .subscribe(onNext: { (result) in
            print(result)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        first.onNext("🐱")
        variable.value = second
        second.onNext("🅱️")
        first.onNext("🐶")
        
    }
    func filterTest2() -> Void {
        Observable.of(1,2,32,44,56,7).filter({ (result) -> Bool in
            if result > 32{
                return true
            }else{
                return false
            }
        }).subscribe(onNext: { (result) in
            print(result)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    func filterTest3() -> Void {
        textfield.rx.text.asObservable().filter { (result) -> Bool in
            let str = result! as NSString
            if str.length > 11{
                return true
            }else{
                return false
            }
            }.asObservable().subscribe(onNext: {[unowned self] (result) in
                print(result)
                var str = result! as NSString
                str = str.substring(to: 11) as NSString
                self.textfield.text = str as String
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
}

