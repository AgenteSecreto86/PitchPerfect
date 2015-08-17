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
    
    var audioPlayer: AVAudioPlayer!
    var recievedAudio: RecordedAudio!

    @IBOutlet weak var stopPlayingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: recievedAudio.filePathURL)
            audioPlayer.delegate = self
            audioPlayer.enableRate = true
            audioPlayer.prepareToPlay()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func playSoundSlowly(sender: UIButton) {
        playSoundsWithRate(0.5)
    }
    
    @IBAction func playSoundsFast(sender: UIButton) {
        playSoundsWithRate(1.5)
    }
    
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop()
    }
    
    func playSoundsWithRate(rate: Float) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.volume = 1.0
        stopPlayingButton.hidden = false
        
        audioPlayer.play()
    }
        
    //MARK: - AVAudioPlayerDelegate Protocol
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        if let error = error {
            print(error.localizedDescription)
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            stopPlayingButton.hidden = true
        }
    }
    
    
}
