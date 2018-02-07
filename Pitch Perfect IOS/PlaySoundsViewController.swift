//
//  PlaySoundsViewController.swift
//  Pitch Perfect IOS
//
//  Created by Sahib on 07/02/18.
//  Copyright © 2018 RTS Production. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    //MARK: Button Outlets
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var pauseButton : UIButton!
    
    
    //MARK: AudioEngine
    var recordedAudioURL : URL!
    var audioFile : AVAudioFile!
    var audioEngine : AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var stopTimer : Timer!
    
    enum ButtonType : Int {
        case slow = 0,fast,chimpuk,vader,echo,reverb
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    //MARK: PlayAudio Function
    @IBAction func playSoundAction(_sender : UIButton){
        switch (ButtonType(rawValue : _sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate : 1.5)
        case .chimpuk:
            playSound(pitch : 1300)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo : true)
        case .reverb:
            playSound(reverb : true)
        }
        configureUI(.playing)
    }
    @IBAction func pauseButtonAction(_sender : UIButton){
        stopAudio()
    }
}
