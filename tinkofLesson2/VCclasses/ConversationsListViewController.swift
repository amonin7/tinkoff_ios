//
//  allChatsViewController.swift
//  tinkofLesson2
//
//  Created by Andrey Minin on 24/02/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController {
    
    @IBOutlet weak var mainTabView: UITableView!
    
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
            //print(sender)
        }
    }
    
    func setupTV() {
        navigationItem.title = "Tinkoff Chat"
        navigationController?.navigationBar.prefersLargeTitles = true
        getData()
    }

}

extension ConversationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! Mycell
        cell.configire(indexPath: indexPath)
        return cell

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
    
    func configire(indexPath: IndexPath) {
        
        nicknameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        messageLabel.textColor = .gray
        
        if indexPath.row == 0 {
            name = "user1"
            message = user1MH[user1MH.count - 1].text
            hasUnreadMessages = user1MH[user1MH.count - 1].is_read
            date = user1MH[user1MH.count - 1].date
            online = true
        }
        if indexPath.row == 1 {
            name = "user2"
            message = user2MH[user1MH.count - 1].text
            hasUnreadMessages = user1MH[user1MH.count - 1].is_read
            date = user1MH[user1MH.count - 1].date
            online = true
        }
        if indexPath.row == 2 {
            name = "user3"
            message = user3MH[user1MH.count - 1].text
            hasUnreadMessages = user1MH[user1MH.count - 1].is_read
            date = user1MH[user1MH.count - 1].date
            online = true
        }
        if indexPath.row == 3 {
            name = "user4"
            message = user4MH[user1MH.count - 1].text
            hasUnreadMessages = user1MH[user1MH.count - 1].is_read
            date = user1MH[user1MH.count - 1].date
            online = true
        }
        if indexPath.row == 4 {
            name = "user5"
            message = user5MH[user1MH.count - 1].text
            hasUnreadMessages = user1MH[user1MH.count - 1].is_read
            date = user1MH[user1MH.count - 1].date
            online = true
        }
        if indexPath.row == 5 {
            name = "user6"
            message = user6MH[user1MH.count - 1].text
            hasUnreadMessages = user1MH[user1MH.count - 1].is_read
            date = user1MH[user1MH.count - 1].date
            online = true
        }
        if indexPath.row == 6 {
            name = "user7"
            message = user7MH[user1MH.count - 1].text
            hasUnreadMessages = user1MH[user1MH.count - 1].is_read
            date = user1MH[user1MH.count - 1].date
            online = true
        }
        if indexPath.row == 7 {
            name = "user8"
            message = user8MH[user1MH.count - 1].text
            hasUnreadMessages = user1MH[user1MH.count - 1].is_read
            date = user1MH[user1MH.count - 1].date
            online = true
        }
        if indexPath.row == 8 {
            name = "user9"
            message = user9MH[user1MH.count - 1].text
            hasUnreadMessages = user1MH[user1MH.count - 1].is_read
            date = user1MH[user1MH.count - 1].date
            online = true
        }
        if indexPath.row == 9 {
            name = "user10"
            message = user10MH[user1MH.count - 1].text
            hasUnreadMessages = user1MH[user1MH.count - 1].is_read
            date = user1MH[user1MH.count - 1].date
            online = true
        }
        if indexPath.row == 10 {
            name = "user11"
            message = user11MH[user1MH.count - 1].text
            hasUnreadMessages = user1MH[user1MH.count - 1].is_read
            date = user1MH[user1MH.count - 1].date
            online = true
        }
        if indexPath.row == 11 {
            name = "user12"
            message = user12MH[user1MH.count - 1].text
            hasUnreadMessages = user1MH[user1MH.count - 1].is_read
            date = user1MH[user1MH.count - 1].date
            online = true
        }
        
        nicknameLabel.text = name
        messageLabel.text = message
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateAndTimeLabel.text = dateFormatter.string(from: date!)

    }

}

func getname(indexPath: IndexPath) -> String {
    var name: String?
    if indexPath.row == 0 {
        name = "user1"
    }
    if indexPath.row == 1 {
        name = "user2"
    }
    if indexPath.row == 2 {
        name = "user3"
    }
    if indexPath.row == 3 {
        name = "user4"
    }
    if indexPath.row == 4 {
        name = "user5"
    }
    if indexPath.row == 5 {
        name = "user6"
    }
    if indexPath.row == 6 {
        name = "user7"
    }
    if indexPath.row == 7 {
        name = "user8"
    }
    if indexPath.row == 8 {
        name = "user9"
    }
    if indexPath.row == 9 {
        name = "user10"
    }
    if indexPath.row == 10 {
        name = "user11"
    }
    if indexPath.row == 11 {
        name = "user12"
    }
    return name ?? "no user detected"
}
