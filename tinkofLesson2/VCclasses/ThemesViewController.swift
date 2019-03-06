//
//  ThemesViewController.swift
//  tinkofLesson2
//
//  Created by Andrey Minin on 06/03/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
    
    var model: Themes?

    override func viewDidLoad() {
        super.viewDidLoad()
        model = Themes()
        
        setupButton(button: theme1)
        setupButton(button: theme2)
        setupButton(button: theme3)
        theme1.backgroundColor = model?.theme1;
        theme2.backgroundColor = model?.theme2;
        theme3.backgroundColor = model?.theme3;
        
        self.view.backgroundColor = UserDefaults.takeColor()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var theme1: UIButton!
    @IBOutlet weak var theme2: UIButton!
    @IBOutlet weak var theme3: UIButton!

    @IBAction func theme1Picked(_ sender: UIButton) {
        self.view.backgroundColor = model?.theme1
        UserDefaults.saveColorToUD(color: (model?.theme1)!)
    }
    @IBAction func theme2Picked(_ sender: UIButton) {
        self.view.backgroundColor = model?.theme2
        UserDefaults.saveColorToUD(color: (model?.theme2)!)
    }
    @IBAction func theme3Picked(_ sender: UIButton) {
        self.view.backgroundColor = model?.theme3
        UserDefaults.saveColorToUD(color: (model?.theme3)!)
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        ConversationsListViewController.reset()
    }

}

extension ThemesViewController {
    func setupButton(button : UIButton) {
        button.layer.borderWidth = 1.5;
        button.layer.cornerRadius = 7;
    }
}
