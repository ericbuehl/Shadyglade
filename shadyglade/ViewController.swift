//
//  ViewController.swift
//  pool
//
//  Created by Eric Buehl on 9/21/14.
//  Copyright (c) 2014 Eric Buehl. All rights reserved.
//

import UIKit
import Alamofire

let shadeBase = "http://192.168.1.54:7378"
let poolBase = "http://192.168.1.50:7379"
//let base = "https://192.168.1.51:7379" // rpi01


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        println("viewDidLoad")
        var timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("reloadView"), userInfo: nil, repeats: true)

    }
    
    override func viewWillAppear(animated: Bool) {
        println("viewWilAppear")
    }
    
    func reloadView() {
        println("reloading view...")
        // Do any additional setup after loading the view, typically from a nib.
        for i in 1...4 {
            Alamofire.request(.GET, shadeBase + "/resources/sensors/shade\(i)/state")
                .responseJSON { (request, response, data, error) in
                    println(error)
                    if let e = error? {
                        var alert = UIAlertController(title: "Error", message: "Couldn't get shade status", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Boooo", style: .Default, handler: { action in
                            switch action.style{
                            case .Default:
                                println("default")
                                
                            case .Cancel:
                                println("cancel")
                                
                            case .Destructive:
                                println("destructive")
                            }
                        }))
                        self.presentViewController(alert, animated: true, completion: nil)
                        return
                    }
                    var updown = ((data as Int) & 1) == 1 ? true : false  // 0 = up, 1 = down, 2 = moving up, 3 = moving down
                    switch i as Int {
                    case 1:
                        self.shade1switch.setOn(updown, animated: false)
                    case 2:
                        self.shade2switch.setOn(updown, animated: false)
                    case 3:
                        self.shade3switch.setOn(updown, animated: false)
                    case 4:
                        self.shade4switch.setOn(updown, animated: false)
                    default:
                        println("huh?")
                    }
            }
        }
        Alamofire.request(.GET, poolBase + "/resources/sensors/spa/state")
            .responseJSON { (request, response, data, error) in
                println(error)
                if let e = error? {
                    var alert = UIAlertController(title: "Error", message: "Couldn't get pool status", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Boooo", style: .Default, handler: { action in
                        switch action.style{
                        case .Default:
                            println("default")
                            
                        case .Cancel:
                            println("cancel")
                            
                        case .Destructive:
                            println("destructive")
                        }
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                }

                switch data as Int {
                case 0:
                    self.spaState.textColor = UIColor.darkGrayColor()
                    self.spaState.text = "Off"
                    self.spaSwitch.on = false
                    self.spaSwitch.enabled = true
                case 1:
                    self.spaState.textColor = UIColor.greenColor()
                    self.spaState.text = "On"
                    self.spaSwitch.on = true
                    self.spaSwitch.enabled = true
                case 2:
                    self.spaState.textColor = UIColor.grayColor()
                    self.spaState.text = "Starting..."
                    self.spaSwitch.on = true
                    self.spaSwitch.enabled = false
                case 3:
                    self.spaState.textColor = UIColor.yellowColor()
                    self.spaState.text = "Warming..."
                    self.spaSwitch.on = true
                    self.spaSwitch.enabled = true
                case 4:
                    self.spaState.textColor = UIColor.orangeColor()
                    self.spaState.text = "Standby"
                    self.spaSwitch.on = true
                    self.spaSwitch.enabled = true
                case 5:
                    self.spaState.textColor = UIColor.grayColor()
                    self.spaState.text = "Stopping..."
                    self.spaSwitch.on = false
                    self.spaSwitch.enabled = false
                default:
                    println("huh?")
                }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        println("didReceiveMemoryWarning")
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var shade1switch: UISwitch!
    @IBOutlet weak var shade2switch: UISwitch!
    @IBOutlet weak var shade3switch: UISwitch!
    @IBOutlet weak var shade4switch: UISwitch!
    @IBOutlet weak var shadeAllSwitch: UISwitch!
 
    @IBOutlet weak var spaSwitch: UISwitch!
    @IBOutlet weak var spaState: UILabel!

    
    @IBAction func spaSceneChange(sender: AnyObject) {
        
        Alamofire.request(.PUT, poolBase + "/resources/sensors/spa/state", parameters: ["value": (sender as UISwitch).on ? "1" : "0"], encoding: .JSONish)
            .response { (request, response, data, error) in
                println(request)
                println(response?.statusCode)
                println(error)
        }
        self.reloadView()

    }
    
    @IBAction func shadeStateChange(sender: AnyObject) {
 
        var objStr = ""
        switch sender as UISwitch{
        case shade1switch:
            objStr = "shade1"
        case shade2switch:
            objStr = "shade2"
        case shade3switch:
            objStr = "shade3"
        case shade4switch:
            objStr = "shade4"
        case shadeAllSwitch:
            objStr = "allShades"
            shade1switch.on = (sender as UISwitch).on
            shade2switch.on = (sender as UISwitch).on
            shade3switch.on = (sender as UISwitch).on
            shade4switch.on = (sender as UISwitch).on
        default:
            println("Unknown sender")
            return
        }

        var newState = (sender as UISwitch).on ? "1" : "0"
        println(newState)
        
        Alamofire.request(.PUT, shadeBase + "/resources/sensors/" + objStr + "/state", parameters: ["value": newState], encoding: .JSONish)
            .response { (request, response, data, error) in
                println(request)
                println(response?.statusCode)
                println(error)
        }
        //Alamofire.upload(.PUT, base + "/resources/sensors/" + objStr + "/state", (newState as NSString).dataUsingEncoding(NSUTF8StringEncoding)!)

    }

}
