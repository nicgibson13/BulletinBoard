//
//  MessageController.swift
//  BulletinBoard
//
//  Created by Nic Gibson on 7/8/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import Foundation

class MessageController {
    //Shared Instance
    static let sharedInstace = MessageController()
    
    //SOT
    var messages: [Message] = []
    
    //MARK: CRUD Functions
    //Create
    func saveMessageRecord(_ text: String) {
        // init a message
        let messageToSave = Message(text: text)
        let database = CloudKitController.sharedInstance.publicDatabase
        
        CloudKitController.sharedInstance.saveRecordToCloudKit(record: messageToSave.cloudKitRecord, database: database) { (success) in
            if success {
                print("We did it")
                self.messages.append(messageToSave)
            }
        }
    }
    
    //Read
    func fetchMessageRecords() {
        let database = CloudKitController.sharedInstance.publicDatabase
        CloudKitController.sharedInstance.fetchRecordsOf(type: Message.typeKey, database: database) { (records, error) in
            if let error = error {
                print("error in \(#function), \(error.localizedDescription)")
            }
            
            // verify records exist
            guard let foundRecords = records else { return }
            
            // Iterates through foundRecords, init Messages from the values that can init a Message, creating a new array from successes
            let messages = foundRecords.compactMap( {Message(record: $0)})
            
            // Set source of truth
            self.messages = messages
        }
    }
}
