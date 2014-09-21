//
//  ViewController.swift
//  pool
//
//  Created by Eric Buehl on 9/21/14.
//  Copyright (c) 2014 Eric Buehl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        println("viewDidLoad")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        println("didReceiveMemoryWarning")
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var label: UILabel!

    @IBAction func sliderValueChanged(sender: UISlider) {
        var cv = Int(sender.value)
        label.text = "\(cv*2)"
    }
}

