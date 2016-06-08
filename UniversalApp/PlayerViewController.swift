//
//  PlayerViewController.swift
//  UniversalApp
//
//  Created by Mahesh Y on 08/06/16.
//  Copyright © 2016 Rama kuppa. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController,YTPlayerViewDelegate {

    
    @IBOutlet weak var playerView: YTPlayerView!
    var VideoID:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerView.delegate = self;
        self.playerView.loadWithVideoId(VideoID)
        
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    func playerView(playerView: YTPlayerView!, didChangeToState state: YTPlayerState) {
        switch (state){
        case YTPlayerState.Playing:
            break
        case YTPlayerState.Paused:
            break
        default:
            break
        }
    }
    //MARK: Delegate method
    
    func playerView(playerView: YTPlayerView!, didChangeToQuality quality: YTPlaybackQuality) {
    }
    
    func playerView(playerView: YTPlayerView!, receivedError error: YTPlayerError) {
    }
    
    func playerViewDidBecomeReady(playerView: YTPlayerView!) {
        self.playerView.playVideo()
    }

}
