//
//  Communicators.swift
//  tinkofLesson2
//
//  Created by Andrey Minin on 19/03/2019.
//  Copyright © 2019 Andrey Minin. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol CommunicatorDelegate : class {
    //discovering
    func didFoundUser( userID : String, userName : String?)
    func didLostUser( userID : String)
    
    //errors
    func failedToStartBrowsingForUsers(error : Error)
    func failedToStartAdvertising(error : Error)
    
    //messages
    func didReceiveMessage(text : String, fromUser : String, toUser: String)
}

protocol ManagerDelegate : class {
    // Manager delegation functions
    func globalUpdate()
}


class CommunicationManager: CommunicatorDelegate {
    
    func failedToStartAdvertising(error: Error) {
        
    }
    
    
    static let shared = CommunicationManager() // Making singleton
    var multiPeerCommunicator: MultipeerCommunicator!
    var delegate: ManagerDelegate! // Delegate to talk to ViewController
    
    private init() {
        self.multiPeerCommunicator = MultipeerCommunicator()  //Setting up the instance of MultiPeerCommunicator
        self.multiPeerCommunicator.delegate = self  // Setting up the delegate
    }
    
    var listOfBlabbers: [String : Blabber] = [:]
    
    func didFoundUser(userID: String, userName: String?) {
        // If Blabber already exsists, just making him online:
        if let newBlabber = listOfBlabbers[userID] {
            newBlabber.online = true
        } else {
            // If not adding him to the list:
            let newBlabber = Blabber(id: userID, userName: userName!)
            newBlabber.online = true
            listOfBlabbers[userID] = newBlabber
        }
        DispatchQueue.main.async {
            self.delegate.globalUpdate()
        }
    }
    
    func didLostUser(userID: String) {
        if let newBlabber = listOfBlabbers[userID] {
            newBlabber.online = false
            listOfBlabbers.removeValue(forKey: userID)
        }
        DispatchQueue.main.async {
            self.delegate.globalUpdate()
        }
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
        print(error.localizedDescription)
    }
    
    func failedToStartAdvertisingForUsers(error: Error) {
        print(error.localizedDescription)
    }
    
    func didReceiveMessage(text: String, fromUser: String, toUser: String) {
        
        
    }
    
    
}


protocol Communicator {
    func sendMessage(string: String, to UserID: String, completionHandler: (( _ success : Bool, _ error : Error?) -> ())?)
    var delegate : CommunicatorDelegate? {get set}
    var online : Bool {get set}
}





class MultipeerCommunicator: NSObject, Communicator {
    
    var peer: MCPeerID!
    
    //var displayName = UserDefaults.standard.string(forKey: "profileName") ?? "Default name"
    
    var displayName = UIDevice.current.name
    
    var serviceBrowser: MCNearbyServiceBrowser!
    
    var advertiser: MCNearbyServiceAdvertiser!
    
    weak var delegate: CommunicatorDelegate?
    
    var activeSessions: [String: MCSession] = [:]
    
    var online: Bool = false
    
    override init() {
        // Setting up my peer ID:
        peer = MCPeerID(displayName: displayName)
        // Setting up advertiser:
        advertiser = MCNearbyServiceAdvertiser(peer: peer, discoveryInfo: ["userName": displayName], serviceType: "tinkoff-chat")
        // Setting up browser:
        serviceBrowser = MCNearbyServiceBrowser(peer: peer, serviceType: "tinkoff-chat")
        super.init()
        // Settin up delegates:
        serviceBrowser.delegate = self
        advertiser.delegate = self
        // Let the magic begin:
        advertiser.startAdvertisingPeer()
        serviceBrowser.startBrowsingForPeers()
        
        print("Прошла инициализация соединения...")
    }
    
    
    func manageSession(with peerID: MCPeerID) -> MCSession {
        // Проверяем, есть ли этот юзер в словаре сессий, если нет - добавляем:
        guard activeSessions[peerID.displayName] == nil else { return activeSessions[peerID.displayName]! }
        let session = MCSession(peer: peer, securityIdentity: nil, encryptionPreference: .none)
        
        session.delegate = self
        
        // Закидываем сессию на юзера:
        activeSessions[peerID.displayName] = session
        return activeSessions[peerID.displayName]!
    }
    
    
    func sendMessage(string: String, to UserID: String, completionHandler: ((Bool, Error?) -> ())?) {
        // Забираем сессию юзера из массива
        guard let session = activeSessions[UserID] else {return}
        
        // Готовим сообщение:
        let preparedMessageToSend = ["eventType" : "TextMessage", "messageId" : generateMessageId(), "text" : string]
        
        // Формируем JSON сообщения:
        guard let data = try? JSONSerialization.data(withJSONObject: preparedMessageToSend, options: .prettyPrinted) else { return }
        
        // Пытаемся отправить или забираем ошибку:
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
            
            // Обрабатываем свое сообщение:
            delegate?.didReceiveMessage(text: string, fromUser: peer.displayName, toUser: UserID)
            if let completion = completionHandler {
                completion(true, nil)
            }
        } catch let error {
            if let completion = completionHandler {
                completion(false, error)
            }
        }
    }
}

extension MultipeerCommunicator {
    func generateMessageId() -> String {
        let string = "\(arc4random_uniform(UINT32_MAX))+\(Date.timeIntervalSinceReferenceDate)+\(arc4random_uniform(UINT32_MAX))".data(using: .utf8)?.base64EncodedString()
        return string!
    }
}




extension MultipeerCommunicator: MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        let cur_sess = manageSession(with: peerID)
        browser.invitePeer(peerID, to: cur_sess, withContext: nil, timeout: 10000)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        let session = manageSession(with: peerID)
        if session.connectedPeers.contains(peerID) {
            invitationHandler(false, nil)
        } else {
            invitationHandler(true, session)
        }
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let nsdata = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        print(nsdata)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    }
}

class Blabber {
    var id : String
    var name : String
    var online = false
    
    init(id : String, userName : String) {
        self.id = id
        self.name = userName
    }
}

