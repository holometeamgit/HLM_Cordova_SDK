//
//  HolomeViewController+ARSCNViewDelegate.swift
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


extension HolomeViewController : ARSCNViewDelegate {
    
    /// SCNSceneRendererDelegate renderer method
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let featurePointsArray = holomeSDK.getFeaturePointsArray() else {
            return
        }
        
        let isVideoObjectInView = holomeSDK.isVideoObjectInView() && isVideoNodeShown;
        
        DispatchQueue.main.async {
            self.holomeSDK.updateFocusSquare(hideFocusSquare: isVideoObjectInView);
        }
        
        guard let lightEstimate = self.sceneView.session.currentFrame?.lightEstimate else {
            return
        }
        
        holomeSDK.updateLightNodesLightEstimation(lightEstimate: lightEstimate)
    }
}
