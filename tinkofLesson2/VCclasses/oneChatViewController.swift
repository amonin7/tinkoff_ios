//
//  oneChatViewController.swift
//  tinkofLesson2
//
//  Created by Andrey Minin on 24/02/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import UIKit

class oneChatViewController: UIViewController {

    @IBOutlet weak var chatTV: UITableView!
    
    var opponentName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = opponentName
        chatTV.reloadData()
        self.chatTV.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension oneChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user1MH.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as! IncomeCell
            cell.configure(indexPath: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "outcomeCell", for: indexPath) as! OutcomeCell
            cell.configure(indexPath: indexPath)
            return cell
        }
        
    }
    
    
}

extension oneChatViewController: UITableViewDelegate {
    
}

class IncomeCell : UITableViewCell {
    
    @IBOutlet weak var opponentUserIcon: UIImageView!
    
    @IBOutlet weak var incomeMesLabel: UILabel!
    
    func configure(indexPath: IndexPath) {
        
        opponentUserIcon.backgroundColor = .green
        incomeMesLabel.text = "income!!!"
    }
}

class OutcomeCell : UITableViewCell {
    @IBOutlet weak var outcomeMesLabel: UILabel!
    func configure(indexPath: IndexPath) {
        outcomeMesLabel.text = "outcome!!!"
    }
}
