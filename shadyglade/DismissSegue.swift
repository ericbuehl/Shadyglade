//
//  DismissSegue.swift
//  shadyglade
//
//  Created by Eric Buehl on 11/30/14.
//  Copyright (c) 2014 Eric Buehl. All rights reserved.
//

import UIKit


@objc(DismissSegue)  // stupid swift/objc name mangling: http://stackoverflow.com/questions/24185345/custom-segue-in-swift
class DismissSegue : UIStoryboardSegue {
    override func perform() {
        self.sourceViewController.presentingViewController??.dismissViewControllerAnimated(true, completion: nil)
    }
}