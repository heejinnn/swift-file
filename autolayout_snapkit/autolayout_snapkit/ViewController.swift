//
//  ViewController.swift
//  autolayout_snapkit
//
//  Created by 최희진 on 2023/06/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var yellowBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()

    lazy var greenBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    lazy var redBox = { () -> UIView in
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var btnBox = { () -> UIView in
        let view = UIView()
        return view
    }()
    
    lazy var downButton = { (color: UIColor) -> UIButton in
        let btn = UIButton(type: .system)
        btn.backgroundColor = color
        btn.setTitle("아래 이동", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 16
        
        return btn
    }
    
    lazy var upButton = { (color: UIColor) -> UIButton in
        let btn = UIButton(type: .system)
        btn.backgroundColor = color
        btn.setTitle("위로 이동", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 16
        
        return btn
    }
    
    
    
    var greenBoxTopNSLayoutConstraint : NSLayoutConstraint? = nil
    
    var greenBoxTopConstraint : Constraint? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(yellowBox)
        self.view.addSubview(greenBox)
        self.view.addSubview(redBox)
        self.view.addSubview(btnBox)
        
        let myDownBtn = downButton(.darkGray)
        btnBox.addSubview(myDownBtn)
        
        let myUpBtn = upButton(.darkGray)
        btnBox.addSubview(myUpBtn)
                
        yellowBox.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
        
        redBox.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
        }
        
        myDownBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.bottom.equalTo(yellowBox.safeAreaLayoutGuide.snp.bottom)
        }
        
        myDownBtn.addTarget(self, action: #selector(moveGreenBoxDown), for: .touchUpInside)
        
        
        myUpBtn.snp.makeConstraints{(make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.bottom.equalTo(btnBox.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(myDownBtn.snp.right).offset(20)
        }
        myUpBtn.addTarget(self, action: #selector(moveGreenBoxUp), for: .touchUpInside)

        greenBox.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            self.greenBoxTopConstraint = make.top.equalTo(redBox.snp.bottom).offset(20).constraint
        }
        btnBox.snp.makeConstraints{(make) in
            make.width.equalTo(220)
            make.height.equalTo(100)
            make.bottom.equalTo(yellowBox.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalTo(yellowBox)
        }
        
        
    }
    
    var offset = 0
    
    @objc fileprivate func moveGreenBoxDown(){
        offset += 40
        print("ViewController - moveGreenBoxDown() called / offset: \(offset)")
        
        self.greenBoxTopConstraint?.update(offset: offset)
        
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
            self.view.layoutIfNeeded()
        }).startAnimation()
                
    }
    
    @objc fileprivate func moveGreenBoxUp(){
        offset -= 40
        print("ViewController - moveGreenBoxUp() called / offset: \(offset)")
        
        self.greenBoxTopConstraint?.update(offset: offset)
        
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
            self.view.layoutIfNeeded()
        }).startAnimation()
                
    }

}


