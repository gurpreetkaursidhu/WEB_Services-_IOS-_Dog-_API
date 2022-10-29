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
        return animal.count
        
        
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
        
        
    // perform segue operation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        //set cell as index
        let index = tableView.indexPathForSelectedRow!.row
        //set selected dog name value (string)
        let selectedDog = animal[index].self
        let dst = segue.destination as! FullImageViewController
        //set dog breed view controller's variable dogName as selected dog name
        dst.dogName = selectedDog
    }
    
}


