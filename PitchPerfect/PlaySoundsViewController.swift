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

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
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
        audioPlayer.play()
    }
    
    
    //MARK: - AVAudioPlayerDelegate Protocol
    
    func audioPlayerBeginInterruption(player: AVAudioPlayer) {
        
    }
    
    func audioPlayerEndInterruption(player: AVAudioPlayer) {
        
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer, error: NSError?) {
        if let error = error {
            print(error.localizedDescription)
        }
        
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("Done successfully")
        }
    }
    
    
}
