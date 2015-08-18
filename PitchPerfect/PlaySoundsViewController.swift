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
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!

    @IBOutlet weak var stopPlayingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Config and prepare audioPlayer for the "slow" and "fast" action buttons
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: recievedAudio.filePathURL)
            audioPlayer.delegate = self
            audioPlayer.enableRate = true
            audioPlayer.prepareToPlay()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        // Config a audioFile and obtain an audioEngine
        do {
            audioFile = try AVAudioFile(forReading: recievedAudio.filePathURL)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        audioEngine = AVAudioEngine()
        
    }
    
    @IBAction func playSoundSlowly(sender: UIButton) {
        playSoundsWithRate(0.5)
    }
    
    @IBAction func playSoundsFast(sender: UIButton) {
        playSoundsWithRate(1.5)
    }
    
    @IBAction func chipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }

    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    @IBAction func stopSound(sender: UIButton) {
        audioPlayer.stop()
    }
    
    func playSoundsWithRate(rate: Float) {
        // Config and play the player
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        audioPlayer.volume = 1.0
        stopPlayingButton.hidden = false
        
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        // Config audioEngine and play the playerNode
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        stopPlayingButton.hidden = false
        
        // Setup the audioPlayerNode
        let audioPlayerNode = AVAudioPlayerNode()
        audioPlayerNode.volume = 1.0
        audioEngine.attachNode(audioPlayerNode)
        
        // Setup the AudioUnit node with the pitch parameter
        let pitchAU = AVAudioUnitTimePitch()
        pitchAU.pitch = pitch
        audioEngine.attachNode(pitchAU)
        
        // Setup a MixerNode
        let mixer = audioEngine.mainMixerNode
        mixer.volume = 1.0
        
        // Connect all the nodes and start the audioEngine
        audioEngine.connect(audioPlayerNode, to: pitchAU, format: nil)
        audioEngine.connect(pitchAU, to: mixer, format: nil)
        do {
            try audioEngine.start()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioPlayerNode.play()
        
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
