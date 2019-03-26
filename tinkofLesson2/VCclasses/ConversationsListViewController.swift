//
//  allChatsViewController.swift
//  tinkofLesson2
//
//  Created by Andrey Minin on 24/02/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit
//import Communicators

class ConversationsListViewController: UIViewController, ManagerDelegate {
    
    lazy var users = [Blabber]()
    
    var multicomm = MultipeerCommunicator()

    let cm = CommunicationManager.shared
    
    @IBOutlet weak var mainTabView: UITableView!
    
    @IBAction func themePickerButonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "themeID", sender: "mainUserProfile")
    }
    @IBAction func profileButton(_ sender: Any) {
        performSegue(withIdentifier: "profileID", sender: "mainUserProfile")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTV()
        mainTabView.reloadData()
        self.mainTabView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatID" {
            let destinationVC = segue.destination as! oneChatViewController
            if let indexPath = mainTabView.indexPathForSelectedRow {
                destinationVC.opponentName = getname(indexPath: indexPath)
            }
        } else if let destinationVC = segue.destination as? ThemesViewController {
                destinationVC.colorToReturn = {(dataReturned) -> ()in
                    self.logThemeChanging(selectedTheme: dataReturned)
                }
        }
        /*else if segue.identifier == "themeID" {
            let destinationVC = segue.destination as! ThemesViewController
            destinationVC.delegate = self
        }*/
    }
    
    func setupTV() {
        
        
        navigationItem.title = "Tinkoff Chat"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UserDefaults.takeColor()
        getData()
    }
    
    func globalUpdate() {
        // Заполняем местный массив:
        users = Array(CommunicationManager.shared.listOfBlabbers.values)
        //  sortBlabbers()
        mainTabView.reloadData()
    }
    

}

extension ConversationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! Mycell
        cell.configire(indexPath: indexPath, users : users)
        return cell

    }
    
    
}

extension ConversationsListViewController {
    func logThemeChanging(selectedTheme: UIColor) {
        print(selectedTheme)
    }
}

extension ConversationsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Online"
        } else if section == 1{
            return "History"
        } else {
            return "not yet inited"
        }
    }
    
    
}
protocol ConversationCellConfiguration : class {
    var name: String? {get set}
    var message: String? {get set}
    var date: Date? {get set}
    var online: Bool? {get set}
    var hasUnreadMessages: Bool? {get set}
}
class Mycell: UITableViewCell, ConversationCellConfiguration {
    
    var name: String?
    
    var message: String?
    
    var date: Date?
    
    var online: Bool?
    
    var hasUnreadMessages: Bool?
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    
    func configire(indexPath: IndexPath, users : [Blabber] ) {
        
        nicknameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        messageLabel.textColor = .gray
        
        name = users[indexPath.row].name
        
        message = user1MH[user1MH.count - 1].text
        hasUnreadMessages = user1MH[user1MH.count - 1].is_read
        date = user1MH[user1MH.count - 1].date
        online = true
        
        nicknameLabel.text = name
        messageLabel.text = message
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateAndTimeLabel.text = dateFormatter.string(from: date!)

    }

}

func getname(indexPath: IndexPath) -> String {
    return "user\(indexPath.row + 1)"
}


extension UserDefaults {
    class func saveColorToUD(color: UIColor) {
        let colorToSetAsDefault : UIColor = color
        if let data2 = try! NSKeyedArchiver.archivedData(withRootObject: colorToSetAsDefault, requiringSecureCoding: false) as NSData?
        {
            UserDefaults.standard.set(data2, forKey: "userHeadingColor")
            UserDefaults.standard.synchronize()
        } else {
            print("error")
        }

        
    }
    class func takeColor() -> UIColor {
        if let data = UserDefaults.standard.value(forKey: "userHeadingColor")
        {
            let color = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data as! Data)
            return color as! UIColor
        } else {
            return .gray
        }
    }
    
}

extension ConversationsListViewController {
    class func reset() {
        UINavigationBar.appearance().barTintColor = UserDefaults.takeColor()
    }
}



