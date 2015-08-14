//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Jesus Marcano on 8/13/15.
//  Copyright © 2015 Agencia Secreta 86. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var recordingInProgress: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }
    
    func appInBackground() {
        // called by the app delegate when the app goes background
        stopRecording()
        stopButton.hidden = true
        recordButton.enabled = true
        
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
    }

    @IBAction func stopRecording() {
        recordingInProgress.hidden = true
    }
    
}

