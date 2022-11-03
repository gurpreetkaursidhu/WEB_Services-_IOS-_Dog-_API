//
//  BreedListTableViewController.swift
//  WEBSERVICES_API
//
//  Created by Gurpreet Kaur on 2022-10-29.
//  A00252915

import UIKit

class BreedListTableViewController: UITableViewController {
    
    var dog = [String]()
    // declare variables
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 44.0
        APIHelper.fetchdog{newArray in
            self.dog = newArray
            self.tableView.reloadData()
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }
    
    override   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return dog.count
        
        
    }
    
    
    override   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"list", for: indexPath)as!
        TableViewCell
        
     
        cell.BreedName.text = dog[indexPath.row] // label for particular breed
        
        // able to fetch images of the dogs
        APIHelper.fetchdog { newArray in
            let URL: String = "https://dog.ceo/api/breed/"
                let List = newArray[indexPath.row]
                let url: String = URL + List + "/images"
               
                APIHelper.fetchImage(url: url ) {dogImage in
                
                    for _ in 0...100000{
                        continue
                    }
                    do{
                        cell.spinner.isHidden = true
                       
                        try
                        cell.BreedImage.image = UIImage(data: NSData(contentsOf: NSURL(string: dogImage[0])! as URL) as Data)
                    }catch let error{
                        print(error)
                    }
   
               }
        }
        return cell
    }
        
      // new view controller helps to perform the segue ooperation by passing the objects
    // perform segue operation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = tableView.indexPathForSelectedRow!.row
        let selectedDog = dog[index].self
        let dst = segue.destination as! FullImageViewController
       
        dst.dogName = selectedDog
    }
    // selected dog represents the selected breeds
}


