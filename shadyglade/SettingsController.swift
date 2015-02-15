//
//  SettingsController.swift
//  shadyglade
//
//  Created by Eric Buehl on 11/30/14.
//  Copyright (c) 2014 Eric Buehl. All rights reserved.
//

import UIKit


class SettingsController: UIViewController {
    @IBOutlet weak var hostField: UITextField!
    @IBOutlet weak var doneButton: UIButton!

    @IBAction func doneButtonPressed(sender: AnyObject) {
        println("done button pressed")

        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(hostField.text!, forKey: "baseUrl")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        hostField.text = defaults.stringForKey("baseUrl")

    }
}