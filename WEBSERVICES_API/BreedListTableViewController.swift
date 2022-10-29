//
//  BreedListTableViewController.swift
//  WEBSERVICES_API
//
//  Created by Gurpreet Kaur on 2022-10-29.
//

import UIKit

class BreedListTableViewController: UITableViewController {
    
    var animal = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIHelper.fetchdog{newArray in
            self.animal = newArray
            self.tableView.reloadData()
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
        
        
    }
    
    
    override   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedlist", for: indexPath)as!
        TableViewCell
        
        //set cell's label with dog breed
        cell.BreedName.text = animal[indexPath.row]
        
        //fetch dog name
        APIHelper.fetchdog { newArray in
            let URL: String = "https://dog.ceo/api/breed/"
                let List = newArray[indexPath.row]
                let url: String = URL + List + "/images"
                //fetch dog image with dog breed
                APIHelper.fetchImage(url: url ) {dogImage in
                    //load pause
                    for _ in 0...100000{
                        continue
                    }
                    do{
                        cell.spinner.isHidden = true
                        //transfer image url to UIImage and set cell's image
                        try
                        cell.BreedImage.image = UIImage(data: NSData(contentsOf: NSURL(string: dogImage[0])! as URL) as Data)
                    }catch let error{
                        print(error)
                    }
   
               }
        }
        return cell
    }
        
        
    }

