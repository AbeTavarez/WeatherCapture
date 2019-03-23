//
//  MenuViewController.swift
//  Weather Capture
//
//  Created by Efren Abraham Tavarez on 3/22/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    
    @IBOutlet weak var backButton: UINavigationItem!
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellAbout = tableView.dequeueReusableCell(withIdentifier: "aboutMenuCell", for: indexPath)
        
        //Cell #1 Fahrenheit and Celsius
        if let label = cellAbout.viewWithTag(1) as? UILabel {
//            if indexPath.row == 0 {
                label.text = "About"
//            } else if indexPath.row  == 1 {
//                label.text = "Temperature Scale"
//            } else {
//                label.text = "Error"
//            }
        }
        return cellAbout
        
    }
    
 

    @IBAction func backButtonReturn(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    
    
    

