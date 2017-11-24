//
//  ViewController.swift
//  RXSwiftTest
//
//  Created by 黄世光 on 2017/11/20.
//  Copyright © 2017年 黄世光. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    var disposeBag = DisposeBag()
    var lab = UILabel()
    var textfield = UITextField()
    var button = UIButton()
//    在cell里定义
//    var disposeBags: DisposeBag?
//    重写重用方法的回调
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.disposeBags = nil
//    }
//    cell的使用
//    inputCell?.textField.rx.text.asObservable().filter({ (result) -> Bool in
//    var str = result! as NSString
//    str = str.replacingOccurrences(of: " ", with: "") as NSString
//    if(str.length > 11){
//    str = str.substring(to: 11) as NSString
//    self.inputCell?.textField.text = str as String
//    return false
//    }else{
//    return true
//    }
//    }).subscribe(onNext: { [unowned self] (result) in
//    self.viewModel.phoneNum.value = result!
//    }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: (inputCell?.disposeBags)!)
//    return inputCell!

    //创建信号
    var single1 = Observable<String>.create { (result) -> Disposable in
        print("create")
        result.onNext("1")
        result.onCompleted()
        return Disposables.create()
    }
    var single2 = Observable<Any>.empty()
    
    var single3 = Observable<String>.just("just")
    //of序列
    var single4 = Observable<Any>.of("1",["1":2],3,"4")
    //from序列 从一个序列创建一个可被观察的序列。这里使用$0表示默认的第一个参数
    var single5 = Observable<Any>.from(["1",["1":2],3,"4"])
    //range序列 创建一个发出一系列顺序整数然后终止的序列。
    var single6 = Observable.range(start: 0, count: 10)
    //generate序列 创建一个满足条件的序列。
    var single7 = Observable.generate(initialState: 0, condition: { (result) -> Bool in
        return result < 10
    }, iterate:{$0+1})
    //of序列do
    var single8 = Observable<Any>.of("1",["1":2],3,"4").do(onNext: { (result) in
        print(result)
    }, onError: nil, onCompleted: nil, onSubscribe: nil, onSubscribed: nil, onDispose: nil)
    
    
    
    //subject
    let subject = PublishSubject<String>()
    //Variable
    let variable1 = Variable("🔴")
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        subscribeSingle()
        rxCocoaTest()
        lab.backgroundColor = UIColor.red
        textfield.backgroundColor = UIColor.yellow
        button.backgroundColor = UIColor.blue
        button.setTitle("登录", for: UIControlState.normal)
        self.view.addSubview(lab)
        self.view.addSubview(textfield)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(btn), for: UIControlEvents.touchUpInside)
        textfield.snp.makeConstraints ({ (make) in
            make.top.equalTo(100)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        })
        lab.snp.makeConstraints ({ (make) in
            make.top.equalTo(200)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        })
        button.snp.makeConstraints ({ (make) in
            make.top.equalTo(300)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        })
    }
    func binding() -> Void {
        var resultStr = ""
        textfield.rx.text.bind(to:lab.rx.text).disposed(by: self.disposeBag)
        textfield.rx.text.asObservable().filter({ (result) -> Bool in
            var str = result! as NSString
            print(str)
            
            str = str.replacingOccurrences(of: " ", with: "") as NSString
            if(str.length > 11){
                str = str.substring(to: 11) as NSString
                resultStr = str as String
                return false
            }else{
                return true
            }
        }).subscribe(onNext: { (result) in
            print(result)
            print(resultStr)
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    func subscribeSingle() -> Void {
        singleFoucation()
        singleFoucation2()
        singleFoucation3()
        singleFoucation4()
        singleFoucation5()
        singleFoucation6()
        singleFoucation7()
        singleFoucation8()
        singleFoucation10()
    }
    //订阅信号
    func singleFoucation() -> Void {
        single1.subscribe(onNext: { (result) in
            print(result)
        }, onError: nil, onCompleted: {
            print("onCompleted1")
        }) {
            print("onDisposed1")
        }.disposed(by: self.disposeBag)
        
    }
    //空信号只会返回onCompleted信号
    func singleFoucation2() -> Void {
        single2.subscribe(onNext: { (reslute) in
            print(reslute)
        }, onError: nil, onCompleted: {
            print("onCompleted2")
        }, onDisposed: nil).disposed(by: self.disposeBag)
    }
    //just信号
    func singleFoucation3() -> Void {
        single3.subscribe(onNext: { (reslute) in
            print(reslute)
        }, onError: nil, onCompleted: {
            print("onCompleted3")
        }, onDisposed: nil).disposed(by: self.disposeBag)
    }
    //of序列
    func singleFoucation4() -> Void {
        single4.subscribe(onNext: { (reslute) in
            print(reslute)
        }, onError: nil, onCompleted: {
            print("onCompleted4")
        }, onDisposed: nil).disposed(by: self.disposeBag)
    }
    //from序列
    func singleFoucation5() -> Void {
        single5.subscribe(onNext: { (reslute) in
            print(reslute)
        }, onError: nil, onCompleted: {
            print("onCompleted5")
        }, onDisposed: nil).disposed(by: self.disposeBag)
    }
    //range序列
    func singleFoucation6() -> Void {
        single6.subscribe(onNext: { (reslute) in
            print(reslute)
        }, onError: nil, onCompleted: {
            print("onCompleted6")
        }, onDisposed: nil).disposed(by: self.disposeBag)
    }
    //generate序列
    func singleFoucation7() -> Void {
        single7.subscribe(onNext: { (reslute) in
            print(reslute)
        }, onError: nil, onCompleted: {
            print("onCompleted7")
        }, onDisposed: nil).disposed(by: self.disposeBag)
    }
    //do
    func singleFoucation8() -> Void {
        single8.subscribe(onNext: { (reslute) in
            print(reslute)
        }, onError: nil, onCompleted: {
            print("onCompleted7")
        }, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    //subject
    func singleFoucation9() -> Void {
        subject.asObserver().onNext("abcd")
    }
    func singleFoucation10() -> Void {
        subject.subscribe(onNext: { (result) in
            print(result)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    //button的点击事件
    func rxCocoaTest() -> Void {
        let observable = button.rx.tap.asObservable()
        
        observable.subscribe(onNext: { (result) in
            print("button点击")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
    }
    @objc func btn() -> Void {
      singleFoucation9()
        let vc = FirstViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    

}

