//
//  MessageViewController.swift
//  BulletinBoard
//
//  Created by Nic Gibson on 7/8/19.
//  Copyright © 2019 Nic Gibson. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        MessageController.sharedInstace.fetchMessageRecords()

    }
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let messageText = textField.text, messageText != "" else {return}
        MessageController.sharedInstace.saveMessageRecord(messageText)
        textField.text = ""
    }
    
}

extension MessageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageController.sharedInstace.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        let message = MessageController.sharedInstace.messages[indexPath.row]
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.timestamp.formatDate()
        return cell
    }
    
    
}
