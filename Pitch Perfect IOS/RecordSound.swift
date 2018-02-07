//
//  RecordSound.swift
//  Pitch Perfect IOS
//
//  Created by Sahib on 07/02/18.
//  Copyright © 2018 RTS Production. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController ,AVAudioRecorderDelegate{
    
    var audioRecorder : AVAudioRecorder!
    
    //MARK: OUTLETS
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var recordB_Outlet: UIButton!
    @IBOutlet weak var stopB_Outlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopB_Outlet.isEnabled = false
    }
    //MARK: Records The Audio
    @IBAction func recordAction(_ sender: Any) {
        buttonActivity(checkActivity: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordingvoice.wav"
        let pathArray = [dirPath,recordingName]
        let filePath = URL(string : pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with : AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url : filePath!,settings : [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    //MARK: Stops The Recording and Save it
    @IBAction func stopAction(_ sender: Any) {
        buttonActivity(checkActivity: false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }
        else{
            print("Recording was Not Successful")
        }
    }
    
    //MARK: Setting ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="stopRecording"{
            let playSoundVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    //MARK: Setting The Layout
    func buttonActivity(checkActivity : Bool){
        if checkActivity{
            recordB_Outlet.isEnabled=false
            stopB_Outlet.isEnabled = true
            recordLabel.text="Recording in Progress"
        }
        else{
            recordB_Outlet.isEnabled=true;
            stopB_Outlet.isEnabled=false
            recordLabel.text="Tap To Record"
        }
    }
    
}

