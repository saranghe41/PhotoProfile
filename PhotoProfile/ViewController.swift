//
//  ViewController.swift
//  PhotoProfile
//
//  Created by 김지은 on 2021/11/08.
//

import UIKit
import YPImagePicker

class ViewController: UIViewController {
    @IBOutlet weak var profileChangeBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("ViewController - viewDidLoad() called")
        
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        profileChangeBtn.layer.cornerRadius = 10
        
        profileChangeBtn.addTarget(self, action: #selector(onProfileChangeBtnClicked), for: .touchUpInside)
    }

    // 프사 변경 버튼이 클릭되었을때
    @objc fileprivate func onProfileChangeBtnClicked() {
        print("ViewController - onProfileChangeBtnClicked() called")
        
        // 카메라 라이브러리 셋팅
        var config = YPImagePickerConfiguration()
//        config.screens = [.library, .photo, .video]
        config.screens = [.library]

        let picker = YPImagePicker(configuration: config)
        
        // 사진이 선택되었을때
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto { 
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                
                self.profileImg.image = photo.image
            }
            // 사진 선택창 닫기
            picker.dismiss(animated: true, completion: nil)
        }
        // 사진 선택창 보여주기
        present(picker, animated: true, completion: nil)
    }
}

