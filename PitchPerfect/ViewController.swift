//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Jesus Marcano on 8/13/15.
//  Copyright © 2015 Agencia Secreta 86. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var recordingSign: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        // note: this method is call also by the AppDelegate in applicatinWillResignActive method.
        recordingSign.hidden = true
    }

    @IBAction func recordAudio(sender: UIButton) {
        recordingSign.hidden = false
    }


}

