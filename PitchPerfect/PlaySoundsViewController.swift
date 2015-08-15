//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Jesus Marcano on 8/14/15.
//  Copyright © 2015 Agencia Secreta 86. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            
        } catch {
            print("failed to initiate audioPlayer")
        }
    }
    
    @IBAction func playSoundSlowly(sender: UIButton) {
        if let player = audioPlayer {
            player.play()
        }
    }
    
    @IBAction func playSoundsFast(sender: UIButton) {
        print("Fast")
    }
    
}
