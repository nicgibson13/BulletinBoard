//
//  CloudKitController.swift
//  BulletinBoard
//
//  Created by Nic Gibson on 7/8/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import Foundation
import CloudKit
class CloudKitController {
    
    // Singleton
    static let sharedInstance = CloudKitController()
    
    // Database instances
    let publicDatabase = CKContainer.default().publicCloudDatabase
    
    //MARK: - CRUD
    //Create
    func saveRecordToCloudKit(record: CKRecord, database: CKDatabase, completion: @escaping (Bool) -> Void) {
        // save the record passed in, complete with an optional error
        database.save(record) { (_, error) in
            if let error = error {
                print("Error in \(#function)😘 : \(error.localizedDescription) /n---/n \(error)")
                completion(false)
            }
            completion(true)
        }
        
    }
    // Read
    func fetchRecordsOf(type: String, database: CKDatabase, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        // Conditions of query, conditions to be return all found values
        let predicate = NSPredicate(value: true)
        // defines the record type we want to find, applies our predicate conditions
        let query = CKQuery(recordType: type, predicate: predicate)
        // Perform query, complete with our optional records and optional error
        database.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function)😘 : \(error.localizedDescription) /n---/n \(error)")
                completion(nil, error)
            }
            if let records = records {
                completion(records, nil)
            }
        }
    }
}
