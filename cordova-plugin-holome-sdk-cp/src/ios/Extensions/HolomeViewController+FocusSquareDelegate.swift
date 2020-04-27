//
//  HolomeViewController+FocusSquareDelegate.swift
//  HelloCordova
//
//  Created by Oisin on 10/04/2019.
//
import Foundation
import UIKit
import SceneKit
import SpriteKit
import ARKit
import CoreMotion

extension HolomeViewController : FocusSquareDelegate {
    
    func hide() {
        self.delegate.sendEvent(eventName: "focusHide");
    }
    
    func unhide() {
        self.delegate.sendEvent(eventName: "focusUnhide");
    }
    
    func displayAsBillboard() {
        self.delegate.sendEvent(eventName: "focusDisplayAsBillboard");
    }
    
    func displayAsOpen() {
        SCNTransaction.begin()
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        SCNTransaction.animationDuration = 0.35
        SCNTransaction.commit()
        self.delegate.sendEvent(eventName: "displayAsOpen");
    }
    
    func displayAsClosed() {
        SCNTransaction.begin()
        SCNTransaction.animationTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        SCNTransaction.animationDuration = 0.35
        SCNTransaction.commit()
        self.delegate.sendEvent(eventName: "displayAsClosed");
    }
}
