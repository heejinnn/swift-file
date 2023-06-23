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
    
    lazy var toggleColor = { () -> UISegmentedControl in
       let toggle = UISegmentedControl()
        // 선택안된 버튼 폰트
        toggle.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.systemGray,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .light)
        ], for: .normal)
        
        // 선택된 버튼 폰트
        toggle.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 0.6752033234, blue: 0.5361486077, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)
        ], for: .selected)
        
        //segment 추가
        toggle.insertSegment(withTitle: "red", at: 0, animated: true)
        toggle.insertSegment(withTitle: "green", at: 1, animated: true)
        
        toggle.selectedSegmentIndex = 0
       return toggle
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
    
    var segmentedIndex: Int? = nil
    
    var redBoxTopConstraint : Constraint? = nil
    var greenBoxTopConstraint : Constraint? = nil
    
    var redOffset = 0
    var greenOffset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(yellowBox)
        self.view.addSubview(greenBox)
        self.view.addSubview(redBox)
        self.view.addSubview(btnBox)
        self.view.addSubview(toggleColor)
        
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
            self.redBoxTopConstraint = make.top.equalTo(self.view.snp.top).offset(20).constraint
        }
        
        myDownBtn.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.bottom.equalTo(yellowBox.safeAreaLayoutGuide.snp.bottom)
        }
        
        myDownBtn.addTarget(self, action: #selector(moveBoxDown), for: .touchUpInside)
        
        
        myUpBtn.snp.makeConstraints{(make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.bottom.equalTo(btnBox.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(myDownBtn.snp.right).offset(20)
        }
        myUpBtn.addTarget(self, action: #selector(moveBoxUp), for: .touchUpInside)

        greenBox.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            self.greenBoxTopConstraint = make.top.equalTo(self.view.snp.top).offset(20).constraint
        }
        btnBox.snp.makeConstraints{(make) in
            make.width.equalTo(220)
            make.height.equalTo(70)
            make.bottom.equalTo(yellowBox.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalTo(yellowBox)
        }
        
        toggleColor.snp.makeConstraints{(make) in
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.bottom.equalTo(btnBox.safeAreaLayoutGuide.snp.top)
            make.centerX.equalTo(yellowBox)
        }
        toggleColor.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
        
    }
    
   
    
    
    //MARK: - methods
    @objc fileprivate func toggleSwitch(){
        let index = CGFloat(toggleColor.selectedSegmentIndex)
        segmentedIndex = Int(index)
        if redOffset == greenOffset{
            if segmentedIndex == 0 {
                greenBox.isHidden = true
                redBox.isHidden = false
            }
            else {
                redBox.isHidden = true
                greenBox.isHidden = false
            }
        }
        else{
            greenBox.isHidden = false
            redBox.isHidden = false
        }
    }
    
    @objc fileprivate func moveBoxDown(){
        print("ViewController - moveBoxDown() called / offset: \(greenOffset) - \(redOffset)")
        
        switch(segmentedIndex){
        case 0:
            redOffset += 40
            self.redBoxTopConstraint?.update(offset: redOffset)
            
            break
        case 1:
            greenOffset += 40
            self.greenBoxTopConstraint?.update(offset: greenOffset)
            
        default:
            redOffset += 40
            self.redBoxTopConstraint?.update(offset: redOffset)
        }
        
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
            self.view.layoutIfNeeded()
        }).startAnimation()
                
    }
    
    @objc fileprivate func moveBoxUp(){
        print("ViewController - moveBoxUp() called / offset: \(greenOffset) - \(redOffset)")
        
        
        switch(segmentedIndex){
        case 0:
            redOffset -= 40
            self.redBoxTopConstraint?.update(offset: redOffset)
            break
        case 1:
            greenOffset -= 40
            self.greenBoxTopConstraint?.update(offset: greenOffset)
            
        default:
            redOffset -= 40
            self.redBoxTopConstraint?.update(offset: redOffset)
        }
        
        UIViewPropertyAnimator(duration: 0.2, curve: .easeOut, animations: {
            self.view.layoutIfNeeded()
        }).startAnimation()
                
    }

}


