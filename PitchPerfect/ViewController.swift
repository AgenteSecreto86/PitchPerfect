//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Jesus Marcano on 8/13/15.
//  Copyright © 2015 Agencia Secreta 86. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var recordingInProgress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.hidden = false
    }

    @IBAction func stopRecording(sender: AnyObject) {
        // this method is called by two objects: 
        // the button and the app delegate when the user 
        // press the Home button on the device.
        // sender is type UIButton or AppDelegate
        
        recordingInProgress.hidden = true
    }
    
    

}

