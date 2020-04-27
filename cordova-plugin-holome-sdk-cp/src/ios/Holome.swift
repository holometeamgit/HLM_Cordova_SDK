
@objc(Holome) class Holome : CDVPlugin {
   
//    var callbackId : String;
    var eventListeners : [String : String]!;
    
    // HolomeSDK View Controller
    var holomeViewController: HolomeViewController!
    
    /// Plugin init mehtod
    override func pluginInitialize() {
        self.eventListeners =  [String: String]();
        
        setupWebView()
        instantiateARViewController();
    }
    
    /// Make WebView transparent and non-clickable
    func setupWebView() {
        webView.backgroundColor = .clear
        webView.isOpaque = false
    }
    
    
    /// Init ARViewController from the Main storyboard
    func instantiateARViewController( ) {
        let storyboard = UIStoryboard(name: "Holome",
                                      bundle: nil)
        guard let holomeViewController = storyboard.instantiateViewController(withIdentifier: "HolomeViewController") as? HolomeViewController else {
            fatalError("HoloMeViewController is not set in storyboard")
        }
        self.holomeViewController = holomeViewController
        self.holomeViewController.delegate = self;
        
        
        DispatchQueue.main.async {
            guard let superview = self.webView.superview else { return }
            superview.insertSubview(self.holomeViewController.view,
                                    belowSubview: self.webView)
            
        }

    }
    
    @objc(placeVideo:)
    func placeVideo(command: CDVInvokedUrlCommand){
        //Place video on focus square
        
        let position = command.arguments[0] as? [String : Int] ?? [:];
        let point : CGPoint = CGPoint(dictionary: position);
        
        self.holomeViewController.placeVideo(touchPoint : point);
        
        let pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK
        )
        
        self.commandDelegate!.send(
            pluginResult,
            callbackId: command.callbackId
        )
    }
    
    @objc(switchVideo:)
    func switchVideo(command: CDVInvokedUrlCommand) {
        var pluginResult : CDVPluginResult!
        
        
        guard let sourceResource = command.argument(at: 0) as? String else {
            return
        }
        
        if self.holomeViewController.switchVideo(source: sourceResource) {
            
            //Switch successfully
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK
            )
        } else {
            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_ERROR,
                messageAs : "File not found"
            )
        }
        
        
        self.commandDelegate!.send(
            pluginResult,
            callbackId: command.callbackId
        )
    }
    
    @objc(setPlaceOnFocusSquare:)
    func setPlaceOnFocusSquare(command: CDVInvokedUrlCommand) {
        let placeOnFocusSquare = command.arguments[0] as! Bool;
        self.holomeViewController.placeOnFocusSquare = placeOnFocusSquare;
    }
    
    
    @objc(zoomVideo:)
    func zoomVideo(command: CDVInvokedUrlCommand) {
        let zoomFactor = command.arguments[0] as? CGFloat ?? 0.5;
        self.holomeViewController.zoomVideo(zoomFactor : zoomFactor);
    }
    
    @objc(initHolome:)
    func initHolome(command: CDVInvokedUrlCommand) {
        var pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR
        )
        
        
        //Option object
        if let options = command.arguments[0]  as? [String: Any] {
            
            if let frame =  options["frame"] as? [String: Int] {
                let rect = CGRect(dictionary: frame);
                self.holomeViewController.setSceneFrame(sceneFrame: rect);
            } else {
                return self.errorWithMessage(message: "Frame not found", callbackId: command.callbackId);
            }

            if let focusSquareData = options["focusSquareData"] as? [String : Any] ?? nil {
                 self.holomeViewController.setFocusSquareData(squareData: focusSquareData);
            }
            
            //Set default to true if key doesn't exist
            let placeOnFocusSquare = options["placeOnFocusSquare"] as? Bool ?? true;
            self.holomeViewController.placeOnFocusSquare = placeOnFocusSquare;
        }
        
        
        //OK
        pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK
        )
        
        self.commandDelegate!.send(
            pluginResult,
            callbackId: command.callbackId
        )
    }
    
    /// MARK: Video methods
    @objc(playVideo:)
    func playVideo(command: CDVInvokedUrlCommand){
        self.holomeViewController.holomeSDK.playVideo();
    }
    
    @objc(pauseVideo:)
    func pauseVideo(command: CDVInvokedUrlCommand){
        self.holomeViewController.holomeSDK.pauseVideo();
    }
    
    @objc(stopVideo:)
    func stopVideo(command: CDVInvokedUrlCommand){
        self.holomeViewController.holomeSDK.stopVideo();
    }
    
    
    @objc(addEventListener:)
    func addEventListener(_ command: CDVInvokedUrlCommand) {
        
        
        let eventName = command.arguments[0] as? String ?? "";
        let pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK
        );
        
        pluginResult?.setKeepCallbackAs(true);
        
        //Assign callback to listener dictionary
        self.eventListeners[eventName] = command.callbackId;
        
        self.commandDelegate!.send(
            pluginResult,
            callbackId: command.callbackId);
    }
    
    /// MARK: Helpers
    func errorWithMessage(message: String  = "" , callbackId: String){
        let pluginResult = CDVPluginResult(
            status: CDVCommandStatus_ERROR,
            messageAs : message
        );
        
        self.commandDelegate!.send(
            pluginResult,
            callbackId: callbackId);
    }
}

