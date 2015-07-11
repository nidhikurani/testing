//
//  playSoundViewController.swift
//  Pitch Perfect
//
//  Created by Jasmeet Singh on 7/10/15.
//  Copyright (c) 2015 Jasmeet Singh. All rights reserved.
//

import UIKit
import AVFoundation

class playSoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!;
    var recievedAudio:RecordedAudio!;
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
     // if  var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3")
      //{
      //  var filePathUrl = NSURL(fileURLWithPath: filePath)
      //  audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
      //  audioPlayer.enableRate = true;
      //  }
      // else
     // {
      //  println("file path is empty");
     // }
        //test
        
        audioPlayer = AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true;
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: recievedAudio.filePathUrl, error: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    @IBAction func playSlowSound(sender: UIButton) {
        audioPlayer.stop();
        audioPlayer.rate = 0.5;
        audioPlayer.play();
    }

    @IBAction func playSoundFast(sender: UIButton) {
        audioPlayer.stop();
        audioPlayer.rate = 1.5;
        audioPlayer.play();
    }
    
    @IBAction func stopPlayingSounds(sender: UIButton) {
        audioPlayer.stop();
    }
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    @IBAction func playDarthVadorAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
