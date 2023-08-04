//
//  ViewController.swift
//  Photo_tutoial
//
//  Created by 최희진 on 2023/04/12.
//

import UIKit
import YPImagePicker

class ViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileChangeBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.layer.cornerRadius = profileImage.frame.height / 2
        //이미지뷰의 높이에 나누기 2해서 나누기 2한 만큼의 원이 생성된다.
        self.profileChangeBtn.layer.cornerRadius = 10
    
        //버튼 클릭 액션 설정
        self.profileChangeBtn.addTarget(self, action: #selector(onProfileChangeBtnClicked), for: .touchUpInside)
        //해당 버튼이 클릭되었을 때 실행시킬 메소드를 선택 (action)
        //touchUpInside : 버튼의 안쪽이 클릭된 경우
        
    }
    
    //profileChangeBtn 버튼이 클릭되었을 때
    @objc fileprivate func onProfileChangeBtnClicked(){
        print("ViewController - onProfileChangeBtnClicked() called")
        
        //카메라 라이브러리 세틸
        var config = YPImagePickerConfiguration()
        config.screens = [.library]
        
        let picker = YPImagePicker(configuration: config)

        //사진이 선택되었을 때
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                
                //프사 이미지 변경
                self.profileImage.image = photo.image
                self.profileImage.layer.borderWidth = 2
                self.profileImage.layer.borderColor = UIColor.black.cgColor
            }
            //사진 선택창 닫기
            picker.dismiss(animated: true, completion: nil)
        }
        //사진 선택창 보여주기
        present(picker, animated: true, completion: nil)
    }


}

