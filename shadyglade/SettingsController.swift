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
    @IBOutlet weak var certField: UITextView!
    @IBOutlet weak var keyField: UITextView!
    @IBOutlet weak var doneButton: UIButton!

    @IBAction func doneButtonPressed(sender: AnyObject) {
        println("done button pressed")

        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(hostField.text!, forKey: "baseUrl")
        defaults.setObject(certField.text!, forKey: "sslCert")
        defaults.setObject(keyField.text!, forKey: "sslKey")

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        certField.layer.borderWidth = 1.0
        certField.layer.borderColor = UIColor.lightGrayColor().CGColor
        keyField.layer.borderWidth = 1.0
        keyField.layer.borderColor = UIColor.lightGrayColor().CGColor
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        hostField.text = defaults.stringForKey("baseUrl")
        certField.text = defaults.stringForKey("sslCert")
        keyField.text = defaults.stringForKey("sslKey")
        
    }
}