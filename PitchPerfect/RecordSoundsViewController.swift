//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Jesus Marcano on 8/13/15.
//  Copyright © 2015 Agencia Secreta 86. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - AudioSession config and notifications
        
        // Obtain and configure an audio session with a category, option and mode and activate.
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions:AVAudioSessionCategoryOptions.MixWithOthers)
            try audioSession.setMode(AVAudioSessionModeDefault)
            try audioSession.setActive(true)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        // Subscribe to audio session interruption notifications
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleAudioSessionInterruption:", name: AVAudioSessionInterruptionNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }
    
    func appInBackground() {
        // for the app delegate when the app goes to the background
        
        stopButton.hidden = true
        recordButton.enabled = true
        recordingInProgress.hidden = true
    }
    
    //MARK: - Notification handler
    
    func handleAudioSessionInterruption(notification: NSNotification) -> Void {
        // userInfo  for this notification contains a dictionary with two keys
        if let userInfo = notification.userInfo {
            
            //FIXME: - breaks here when pressing the lock button on the device.
            
            let interruptionType = userInfo[AVAudioSessionInterruptionTypeKey] as! AVAudioSessionInterruptionType
            let interruptionOption = userInfo[AVAudioSessionInterruptionOptionKey] as! AVAudioSessionInterruptionOptions
            
            switch interruptionType {
            case .Began :
                //TODO: Audio has stopped, session is inactive. Update UI, state etc.
                print("interruption began")
                
            case .Ended :
                //TODO: Reactivate the audio session and update UI
                print("interruption ended")
                // check to continue playback
                if interruptionOption == AVAudioSessionInterruptionOptions.ShouldResume {
                    //TODO: Restart the player if it was playing
                    print("interruption ended. ok to resume playing")
                }
            }
        }
    }

    
    @IBAction func recordAudio(sender: UIButton) {
        
        recordingInProgress.hidden = false
        stopButton.hidden = false
        recordButton.enabled = false
  
        // Configure recorder with settings and sound file URL
        let recordingSettings: Dictionary<String,NSNumber>  = [
            AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let dirArray = [dirPath, "my_audio.wav"]
        let fileURL = NSURL.fileURLWithPathComponents(dirArray)
        
        do {
            audioRecorder = try AVAudioRecorder(URL: fileURL!, settings: recordingSettings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
                
        audioRecorder.record()
    }

    @IBAction func stopRecording() {
        
        recordingInProgress.hidden = true
        
        audioRecorder.stop()
    }
    
    //MARK: - AVAudioRecorderDelegate protocol handlers
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder, error: NSError?) {
        
        print(error?.localizedDescription)
        recordButton.enabled = true
        stopButton.hidden = true
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag {
            recordedAudio = RecordedAudio()
            recordedAudio.filePathURL = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            
        } else {
            print("Recording was not successfull")
            recordButton.enabled = true
            stopButton.hidden = true
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.recievedAudio = data
        }
    }
}

