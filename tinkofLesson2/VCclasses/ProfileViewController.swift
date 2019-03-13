//
//  ViewController.swift
//  tinkofLesson2
//
//  Created by Andrey Minin on 13/02/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var backBut: UIButton!
    
    @IBOutlet var doneBut: UIButton!
    
    @IBOutlet var descriptionNew: UITextField!
    
    @IBOutlet var userNameNew: UITextField!
    
    @IBOutlet weak var addUserPhotoButton: UIButton!
    
    @IBOutlet var optionBut: UIButton!
    
    @IBOutlet var gcdBut: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func editButtonTap(_ sender: Any) {
        editVCLoad()
    }
    
    @IBAction func gcdButTap(_ sender: Any) {
        saveData()
    }
    
    @IBAction func optionButTap(_ sender: Any) {
        
    }
    
    @IBAction func doneButPressed(_ sender: Any) {
        editedVCLoad()
        loadData()

    }
    
    @IBAction func backButPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - pphoto picking
    
    @IBAction func addUserPhotoButtonTap(_ sender: Any) {
        print("Choose profile photo")
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actSheet = UIAlertController(title: "Источник фото", message: "Выберете, как бы вы хотели импортировать фото", preferredStyle: .actionSheet)
        
        actSheet.addAction(UIAlertAction(title: "Камера", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actSheet.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actSheet.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        self.present(actSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImage.image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var tap: UITapGestureRecognizer?

    //единственное что я не понял, это куда именно нужно прописывать сообщение обо frame то есть в какой инициализатор...
    // MARK: - init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        tap = UITapGestureRecognizer(target: self, action: Selector(("handleTap:")))
        writeLogs(methodName: #function)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tap = UITapGestureRecognizer(target: self, action: Selector(("handleTap:")))
        writeLogs(methodName: #function)
    }
    
    
    
    func editedVCLoad() {
        descriptionNew.isEnabled = false
        userNameNew.isEnabled = false
        gcdBut.isHidden = true
        optionBut.isHidden = true
        editButton.isHidden = false
    }
    
    func editVCLoad() {
        descriptionNew.isEnabled = true
        userNameNew.isEnabled = true
        
        gcdBut.backgroundColor = .green
        optionBut.backgroundColor = .green
        
        gcdBut.isHidden = false
        optionBut.isHidden = false
        editButton.isHidden = true
    }
    
    // MARK: - viewDidLoad, viewDidAppear
    
    override func viewDidLoad() {
        loadData()
        editedVCLoad()
        super.viewDidLoad()
        //addUserPhotoButton.isHidden = true
        writeLogs(methodName: #function)
        navigationItem.title = "Profile"
        profileUIelementsInitialize()
        swipe()
        
    }
    override func viewWillLayoutSubviews() {
        changingBorders()
    }
    override func viewDidAppear(_ animated: Bool) {
        writeLogs(methodName: #function)
        // размер фрэйма поменялся по той причине, что был у нас один дефолтный экран со своими размерами (если я правильно понимаю то это размеры экрана который в мэйнсториборд, но могу ошибаться) а потом мы его меняем на тот с которого хотим запустить... поэтому и размеры меняются
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            self.dismiss(animated: true, completion: nil)
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            self.dismiss(animated: true, completion: nil)
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.up {
            self.dismiss(animated: true, completion: nil)
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.down {
            self.dismiss(animated: true, completion: nil)
        }
    }

    func swipe() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    // MARK: - helpfull functions
    
    func writeLogs(methodName: String) {
        print("EditButtonProperty in \(methodName)")
        print(editButton?.frame.width ?? "not inited == nil")
    }
    
    func profileUIelementsInitialize() {
        profileImage.image = #imageLiteral(resourceName: "userProfileImage")
        
        editButton.layer.borderColor = UIColor.black.cgColor
        editButton.layer.borderWidth = 1
        
        //nameLabel.text = "Andrew Monin"
        //descriptionLabel.text = "Passing the IOS classes in FintechTinkoff \nSwift developing is favourite subject \nAnd smth more to expand the description label..."
    }
    
    func changingBorders() {
        addUserPhotoButton.layer.cornerRadius = addUserPhotoButton.frame.width / 2
        profileImage.layer.cornerRadius = addUserPhotoButton.frame.width / 2
        profileImage.layer.masksToBounds = true
        
        addUserPhotoButton.imageEdgeInsets = UIEdgeInsets(
            top: addUserPhotoButton.frame.height/4,
            left: addUserPhotoButton.frame.height/4,
            bottom: addUserPhotoButton.frame.height/4,
            right: addUserPhotoButton.frame.height/4
        )
        
        editButton.layer.cornerRadius = editButton.frame.height / 4.5

    }
    func saveData() {
        //activityIndicatorView.startAnimating()
        var isSaved: Bool = true
        
        
        let name = self.userNameNew.text!
        let photo = self.profileImage.image!
        let info = self.descriptionNew.text!
        
        let backGroundQueue = OperationQueue()
        
        let custom = CustomData(name: name, photo: photo, info: info)
        
        backGroundQueue.addOperation {
            if let encodeName = try? NSKeyedArchiver.archivedData(withRootObject: custom.name, requiringSecureCoding: false) as NSData?,
                let encodePhoto =  custom.photo.jpegData(compressionQuality: 1.0) as NSData?,
                let encodeInfo = try? NSKeyedArchiver.archivedData(withRootObject: custom.info, requiringSecureCoding: false) as NSData?
            {
                let encodedArray: [NSData] = [encodeName!, encodePhoto, encodeInfo!]
                let defaults = UserDefaults.standard
                
                defaults.set(encodedArray, forKey:"custom" )
                defaults.synchronize()
            } else {
                isSaved = false
            }
        }
        
        if isSaved {
            DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Данные сохранены", message: nil, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .default)
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
            }
        } else {
            DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Ошибка", message: "Не удалось сохранить данные", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    let repeatAction = UIAlertAction(title: "Повторить", style: .default) { (action) in self.saveData()}
                    alert.addAction(okAction)
                    alert.addAction(repeatAction)
                    self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func loadData() {
        let globalQueue =  DispatchQueue(label: "com.app.queueAnton", attributes: .concurrent)
        globalQueue.async{
            let defaults = UserDefaults.standard
            if defaults.object(forKey: "custom") != nil {
                
                var customDataEncoded: [NSData] = defaults.object(forKey: "custom") as! [NSData]
                
                let newName: String = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(customDataEncoded[0] as Data) as! String
                let newPhoto: UIImage = UIImage(data: customDataEncoded[1] as Data) ?? #imageLiteral(resourceName: "placeholder-user.png")
                let newDescr: String = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(customDataEncoded[2] as Data) as! String
                
                let customData = CustomData(name: newName, photo: newPhoto, info: newDescr)
                DispatchQueue.main.async {
                        self.userNameNew.text = customData.name
                        self.profileImage.image = customData.photo
                        self.descriptionNew.text = customData.info
                }
            }
        }
    }
    
}

