//
//  FriendTableTableViewController.swift
//  VKClient
//
//  Created by Демьян Горчаков on 26.12.2022.
//

import UIKit

class FriendTableTableViewController: UITableViewController {
    
    let session = Session.shared
    let service = Service()
    var friends = [Friend]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getFriends(token: session.token) { friends in
            self.friends = friends
            
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let friend = friends[indexPath.row]
        cell.textLabel?.text = friend.firstName
        cell.detailTextLabel?.text = friend.lastName
        
        return cell
    }
}
