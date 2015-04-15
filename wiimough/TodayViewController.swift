//
//  TodayViewController.swift
//  wiimough
//
//  Created by Eric Buehl on 3/20/15.
//  Copyright (c) 2015 Eric Buehl. All rights reserved.
//

import UIKit
import NotificationCenter

let manager = AFHTTPRequestOperationManager()

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var progressSpinner: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var ToggleButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    self.progressSpinner.hidesWhenStopped = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startUpdate() {
        self.statusLabel.text = ""
        self.progressSpinner.startAnimating()
    }
    
    func updateStatus() {
        println("updating...")
        manager.GET("http://10.0.1.8:5000/api/device/Abbey", parameters: [], success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in

            
            switch (responseObject as! NSDictionary)["state"] as! Int {
            case 0: 
                self.statusLabel.text = "🌙" //🌚
            default:
                self.statusLabel.text = "🌞"
            }
            self.progressSpinner.stopAnimating()
            
            
            }, failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("FAILED!")
                println(error)
                self.statusLabel.text = "🌵"
                self.progressSpinner.stopAnimating()

        })
    
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        self.startUpdate()
        self.updateStatus()
        
        
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    @IBAction func didToggle(sender: UIButton) {
        println("DID TOUCH")
        self.startUpdate()
        manager.POST("http://10.0.1.8:5000/api/device/Abbey", parameters: ["action":"toggle"], success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            self.updateStatus()
            
            }, failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("FAILED!")
                println(error)
                self.updateStatus()
        })
    }
    
}
