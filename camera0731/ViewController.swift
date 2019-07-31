import MobileCoreServices

import UIKit

class ViewController: UIViewController {
    let imagePickerController = UIImagePickerController()
    var captureImage : UIImage!
    var videoURL : URL!
    var flagImageSave = false
    var takePicture = 0
    var viewPicture = 1
    var takeVideo = 2
    var viewVideo = 3
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func segemented(_ sender: Any) {
        let segment = sender as! UISegmentedControl
       
        //print("\(segment.selectedSegmentIndex)")
        
        switch segment.selectedSegmentIndex {
        case takePicture:
            flagImageSave = true
            //이미지를 선택하거나 취소했을 때 호출될 메소드의 위치를 설정
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = true
            self.present(imagePickerController,animated: true)
            
        case viewPicture:
            //이미지 저장 기능을 사용하지 않기 때문에 설정
            flagImageSave = false
            //이미지를 선택하거나 취소했을 때 호출될 메소드의 위치를 설정
            imagePickerController.delegate = self
            //이미지 피커의 데이터 소스 속성을. 포토 라이브러리로 설정
            imagePickerController.sourceType = .photoLibrary
            //편집가능여부
            imagePickerController.allowsEditing = true
            //화면에 출력
            self.present(imagePickerController,animated: true)
            
        case takeVideo:
            flagImageSave = true
            //이미지를 선택하거나 취소했을 때 호출될 메소드의 위치를 설정
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            imagePickerController.mediaTypes = [kUTTypeMovie as String]
            imagePickerController.allowsEditing = false
            self.present(imagePickerController,animated: true)
            
        case viewVideo:
            flagImageSave = false
            imagePickerController.sourceType = .photoLibrary
            //이미지를 선택하거나 취소했을 때 호출될 메소드의 위치를 설정
            imagePickerController.delegate = self
            imagePickerController.mediaTypes = [kUTTypeMovie as String]
            imagePickerController.allowsEditing = false
            self.present(imagePickerController,animated: true)
            
        default:
            self.present(imagePickerController,animated: true)
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension ViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    //이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //이미지와 동영상을 구분하기 위해서 타입을 가져옵니다.
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        if mediaType.isEqual(to: kUTTypeImage as NSString as String){
            //선택한 이미지 가쟈오기
            captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            //저장 모드라면 저장
            if flagImageSave{
                UIImageWriteToSavedPhotosAlbum(captureImage,self, nil, nil)
            }
            //이미지를 출력
            imageView.image = captureImage
        }
        else if mediaType.isEqual(to: kUTTypeMovie as NSString as String){
            if flagImageSave {
                //동영상 저장된 URL 가져오기
                videoURL = (info[UIImagePickerController.InfoKey.mediaURL] as! URL)
                //동영상저장
                UISaveVideoAtPathToSavedPhotosAlbum(videoURL.relativePath, self, nil, nil)
            }
        }
        
        
        
        //이미지 피커를 닫기
        self.dismiss(animated: true, completion: nil)
    }
    //이미지 선택을 취소했을 때 호출되는 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //이미지 피커 컨트롤러를 화면에서 제거
        self.dismiss(animated: true, completion: nil)
    }
    
}
