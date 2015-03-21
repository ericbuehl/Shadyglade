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
    @IBOutlet weak var ToggleButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    @IBAction func didToggle(sender: UIButton) {
        println("DID TOUCH")
        manager.POST("http://10.0.1.8:5000/api/device/Abbey", parameters: ["action":"toggle"], success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) in
            
            }, failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                println("FAILED!")
                println(error)
        })
    }
    
}
