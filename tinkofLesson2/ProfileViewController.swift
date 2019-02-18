//
//  ViewController.swift
//  tinkofLesson2
//
//  Created by Andrey Minin on 13/02/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var addUserPhotoButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func editButtonTap(_ sender: Any) {
        
    }
    
    @IBAction func addUserPhotoButtonTap(_ sender: Any) {
        print("Choose profile photo")
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
    
    
    
    
    
    // MARK: - viewDidLoad, viewDidAppear
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeLogs(methodName: #function)
        profileInitialize()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        writeLogs(methodName: #function)
        // размер фрэйма поменялся по той причине, что был у нас один дефолтный экран со своими размерами (если я правильно понимаю то это размеры экрана который в мэйнсториборд, но могу ошибаться) а потом мы его меняем на тот с которого хотим запустить... поэтому и размеры меняются
    }

    
    
    
    
    // MARK: - helpfull functions
    
    func writeLogs(methodName: String) {
        print("EditButtonProperty in \(methodName)")
        print(editButton?.frame.width ?? "not inited == nil")
    }
    
    func profileInitialize() {
        profileImage.image = #imageLiteral(resourceName: "userProfileImage")
        addUserPhotoButton.layer.cornerRadius = addUserPhotoButton.frame.width / 2
        profileImage.layer.cornerRadius = addUserPhotoButton.frame.width / 2
        profileImage.layer.masksToBounds = true
        
        addUserPhotoButton.imageEdgeInsets = UIEdgeInsets(
            top: addUserPhotoButton.frame.height/4,
            left: addUserPhotoButton.frame.height/4,
            bottom: addUserPhotoButton.frame.height/4,
            right: addUserPhotoButton.frame.height/4
        )
        
        editButton.layer.borderColor = UIColor.black.cgColor
        editButton.layer.borderWidth = 1
        editButton.layer.cornerRadius = editButton.frame.height / 4.5
    }
}

