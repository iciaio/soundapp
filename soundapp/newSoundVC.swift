//
//  loginVC.swift
//  navigating
//
//  Created by Alicia Iott on 5/16/15.
//  Copyright (c) 2015 Alicia Iott. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class newSoundVC: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    var soundFileURL = NSURL()
    var soundFilePath = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.enabled = false
        stopButton.enabled = false
        
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let docsDir = dirPaths[0] as! String
        self.soundFilePath = docsDir.stringByAppendingPathComponent("sound.caf")
        self.soundFileURL = NSURL(fileURLWithPath: soundFilePath)!
        let recordSettings =
        [AVEncoderAudioQualityKey: AVAudioQuality.Min.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
        
        var error: NSError?
        
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord,
            error: &error)
        
        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        }
        
        audioRecorder = AVAudioRecorder(URL: soundFileURL,
            settings: recordSettings as [NSObject : AnyObject], error: &error)
        
        if let err = error {
            println("audioSession error: \(err.localizedDescription)")
        } else {
            audioRecorder?.prepareToRecord()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordAudio(sender: AnyObject) {
        if audioRecorder?.recording == false {
            playButton.enabled = false
            stopButton.enabled = true
            audioRecorder?.record()
        }
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        stopButton.enabled = false
        playButton.enabled = true
        recordButton.enabled = true
        
        if audioRecorder?.recording == true {
            audioRecorder?.stop()
        } else {
            audioPlayer?.stop()
        }
    }
    
    @IBAction func playAudio(sender: AnyObject) {
        if audioRecorder?.recording == false {
            stopButton.enabled = true
            recordButton.enabled = false
            
            var error: NSError?
            
            audioPlayer = AVAudioPlayer(contentsOfURL: audioRecorder?.url,
                error: &error)
            
            audioPlayer?.delegate = self
            
            if let err = error {
                println("audioPlayer error: \(err.localizedDescription)")
            } else {
                audioPlayer?.play()
            }
        }
    }
    
    @IBAction func submitAudio(sender: AnyObject) {
        if audioRecorder?.recording == false {

            var error: NSError?
            
            let fileData = NSData(contentsOfFile: self.soundFilePath)
            let parseFile = PFFile(name: "sound.caf", data: fileData!)
            var newSound = PFObject(className: "Sounds")
            newSound["file"] = parseFile
            newSound["title"] = self.titleTextField.text
            newSound.saveInBackgroundWithBlock {
                (success: Bool, error: NSError?) -> Void in
                if (success) {
                    println("submit pressed")

                } else {
                    println("error saving sound")
                }
            }
        }
    }
    
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer!, successfully flag: Bool) {
        recordButton.enabled = true
        stopButton.enabled = false
    }
    
    func audioPlayerDecodeErrorDidOccur(player: AVAudioPlayer!, error: NSError!) {
        println("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
    }
    
    func audioRecorderEncodeErrorDidOccur(recorder: AVAudioRecorder!, error: NSError!) {
        println("Audio Record Encode Error")
    }

    
}
