//
//  SettingsTableViewController.swift
//  Weather Capture
//
//  Created by Efren Abraham Tavarez on 3/23/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit





class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var tempSwitch: UISwitch!
    
    
    
    
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        
        UserDefaults.standard.set(sender.isOn, forKey: Constants.useFahreneitKey)
        
        UserDefaults.standard.synchronize()
        
        print(UserDefaults.standard.bool(forKey: Constants.useFahreneitKey))
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tempSwitch.isOn = UserDefaults.standard.bool(forKey: "UseFahrenheit")
        
        
        
//        tempswitch.isOn = UserDefaults.standard.bool(forKey: Constants.useFahreneitKey)
      
    }
    
    
    //done button
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    

    // MARK: - Table view data source


}
