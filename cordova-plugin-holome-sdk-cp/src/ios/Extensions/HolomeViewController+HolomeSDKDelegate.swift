//
//  HolomeViewController+HolomeSDKDelegate.swift
//  HelloCordova
//
//  Created by Oisin on 03/04/2019.
//

import Foundation

extension HolomeViewController : HolomeSDKDelegate {
    
    // MARK: HolomeSDKDelegate methods
    
    func videoLoading() {
        self.delegate.sendEvent(eventName: "videoLoading");
    }
    
    func videoLoadingComplete() {
        self.delegate.sendEvent(eventName: "videoLoadingComplete");
    }
    
    func videoError(type: ErrorTypes, errorMsg: String) {
        self.delegate.sendEvent(eventName: "videoError", data: ["error": errorMsg]);
    }
    
    func videoPlayerStateChanged(state: VideoPlayerStates) {
        currentVideoPlayerStates = state
        let stateStr = String(describing: state)
        
        DispatchQueue.main.async {
            switch state {
            case .PLAYED:
                self.delegate.sendEvent(eventName: "videoPlayerStateChanged", data: ["status" : stateStr]);
                break
            case .PAUSED:
                break
                self.delegate.sendEvent(eventName: "videoPlayerStateChanged", data: ["status" : stateStr]);
            default:
                break
            }
        }
    }
    
    func videoPlaced() {
        isVideoNodeShown = true;
        self.delegate.sendEvent(eventName: "videoPlaced");
    } 
    
    
    func videoNodeHidden(value: Bool) {
        self.isVideoNodeShown = value
        self.delegate.sendEvent(eventName: "videoNodeHidden");
    }
}
