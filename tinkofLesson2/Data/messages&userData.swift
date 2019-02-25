//
//  messages&userData.swift
//  tinkofLesson2
//
//  Created by Andrey Minin on 25/02/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import Foundation
//import NSDate


protocol MessageCellConfiguration : class {
    var text : String? {get set}
}

class Message: MessageCellConfiguration {
    var text: String?
    var is_income: Bool
    var is_read: Bool
    var date: Date
    init(messageText: String?, whose_message: Bool, mes_date: Date, is_read_mes: Bool) {
        self.text = messageText
        self.is_income = whose_message
        self.date = mes_date
        self.is_read = is_read_mes
    }
}

// MARK: - MH == message history

var user1MH = [Message]()
var user2MH = [Message]()
var user3MH = [Message]()
var user4MH = [Message]()
var user5MH = [Message]()
var user6MH = [Message]()
var user7MH = [Message]()
var user8MH = [Message]()
var user9MH = [Message]()
var user10MH = [Message]()
var user11MH = [Message]()
var user12MH = [Message]()

func getData() {
    for i in 1...10 {
        let dateString = "2014-01-\(i)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let s = dateFormatter.date(from: dateString)
        let m = Message(messageText: "message №\(i)", whose_message: i % 2 == 0, mes_date: s!, is_read_mes: false)
        user1MH.append(m)
        user2MH.append(m)
        user3MH.append(m)
        user4MH.append(m)
        user5MH.append(m)
        user6MH.append(m)
        user7MH.append(m)
        user8MH.append(m)
        user9MH.append(m)
        user10MH.append(m)
        user11MH.append(m)
        user12MH.append(m)
    }
}
