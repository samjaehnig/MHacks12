//

//  ListScreenViewController.swift

//  MHacks19

//

//  Created by Sam Jaehnig on 10/12/19.

//  Copyright © 2019 Sam Jaehnig. All rights reserved.

//





import UIKit

import FirebaseDatabase

import FirebaseAuth



class ListScreenViewController: UIViewController {
    var num = 0
    var itemNames = [String]()
    
    @IBOutlet weak var SearchBar: UITextField!
    
    @IBAction func SearchItem(_ sender: UIButton) {
        let name: String = SearchBar.text!
        itemNames.append(name)
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let string_name: String = "Name \(num)"
        ref.child("Cart").setValue([string_name: name])
        num = num + 1
 
    }

    @IBAction func GenerateStores(_ sender: UIButton) {
       
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference!
    
    var databaseHandle:DatabaseHandle?
    
    
    
    var items: [String] = []
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        ref = Database.database().reference()
        
        databaseHandle = ref?.child("Cart").observe(.childAdded, with:{ (snapshot) in
            
            
            let temp = snapshot.value as? String
            
            if let items = temp {
                
                self.items.append(items)
                
                
                self.tableView.reloadData()
                
            }
            
            
            
            
            
        })
        
        
        
    }
    
}



//    func createArray() -> [Item] {

//

//        let databaseRef = Database.database().reference().child("Cart")

//        let databaseHandle = databaseRef.observe(.value, with: { snapshot in

//            for child in snapshot.children {

//                let childSnapshot = snapshot.childSnapshotForPath(child.key)

//                if let dbLocation = child.value["Name"] as? String {

////                print("Hello", child.value["Name"])

////                }

//            }

//        })

////        for item in ref.child("Cart"){

////            let i =  item.value

////            print("Hello: ", i)

////        }

//        //        ref.child("Cart").observe(.value, with: { (snapshot) in

////            if let value = snapshot.value as? String{

////                print("Hello: ",snapshot.value)

////            }

////        })

////        print("Hello: ", ref.child("Cart"))

//

//

//        var tempItems: [Item] = []

//

//        let item1 = Item(title: "apple")

//        let item2 = Item(title: "crackers")

//        let item3 = Item(title: "toothbrush")

//

//        tempItems.append(item1)

//        tempItems.append(item2)

//        tempItems.append(item3)

//

//        return tempItems

//    }

//}





extension ListScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! TableViewCell
        
        
        
        cell.setItem(item: item)
        
        
        
        return cell
        
    }
    
}
