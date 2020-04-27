//
//  HoloMeViewController.swift
//  HelloCordova
//
//  Created by Oisin on 02/04/2019.
//

import Foundation
import UIKit
import SceneKit
import SpriteKit
import ARKit
import CoreMotion

class HolomeViewController : UIViewController{
    
    // MARK: Parameter setup
    
    //AR Scene view
    @IBOutlet weak var sceneView: ARSCNView!
    private var sceneFrame : CGRect!;
    
    //File manager for videos/images
    private var fileManager = FileManager.sharedInstance;
    
    //Delegate
    public weak var delegate : HolomeViewControllerDelegate!;
    
    //Init bools
    public var placeOnFocusSquare : Bool = true;
    public var isVideoNodeShown : Bool = false;

    private var scene : SCNScene!
    
    //VideoStates
    public var currentVideoPlayerStates : VideoPlayerStates!
    
    //Focus square
    public var customFocusSquare : HolomeSDK.FocusSquare!
    
    //HolomeSDK
    var holomeSDK : HolomeSDK!
    
    //Init focus square
    private var data : HolomeSDK.FocusSquare.Data!;
    
    // MARK: Lifecycle
    /// Initlaise HolomeSDK
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set sceneFrame
        self.sceneView.frame = self.sceneFrame;
        
        customFocusSquare = HolomeSDK.FocusSquare(focusSquarePlane : nil, fillPlane : nil, data: data, focusSquareDelegate : self)
        
        scene = SCNScene()
        holomeSDK = HolomeSDK(sceneView: sceneView, holomeSDKDelegate: self, scene: scene, focusSquare: customFocusSquare, arViewDelegate: self)
    }
    
    /// Config for AR World Tracking
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection           = [.horizontal, .vertical]
        configuration.isAutoFocusEnabled       = true;
        configuration.isLightEstimationEnabled = true;
        
        sceneView.session.run(configuration)
    }
    
    // MARK: Helpers
    
    /// Method to set the size of the AR Scene
    /// This is passed down from cordova as an object
    ///
    /// Parameters - CGRect - Defaults to Full size
    func setSceneFrame(sceneFrame : CGRect ) {
        self.sceneFrame = sceneFrame;
    }

    func setFocusSquareData( squareData : [String : Any]  ) {
        self.data = HolomeSDK.FocusSquare.Data(data: squareData); //Calls convinience init in Utils
    }
    
    func placeVideo(touchPoint: CGPoint) {
        if placeOnFocusSquare {
            DispatchQueue.main.async {
                self.holomeSDK.placeVideo(focusSquareLocation: self.customFocusSquare.positioningNode.simdWorldPosition)
            }
        } else {
            self.holomeSDK.placeVideo(touchLocation : touchPoint)
        }
    }
    
    func switchVideo(source: String) -> Bool {
        let path = fileManager.getFilePath(file: source) ?? source; //If file doesn't exist assume it is URL // VideoError will fire if issue
        
        if self.holomeSDK.switchVideo(sourceUrl: path) {
            return true
        } else {
            return false;
        }
    }
    
    func zoomVideo(zoomFactor : CGFloat){
        self.holomeSDK.zoomVideo(factor: zoomFactor);
    }
   
}


//Define delegate events
@objc protocol HolomeViewControllerDelegate {
    func sendEvent(eventName : String, data : [String : Any]);
    func sendEvent(eventName : String);
}
