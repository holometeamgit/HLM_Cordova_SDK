//
//  Holome+HolomeViewControllerDelegate.swift
//  HelloCordova
//
//  Created by Oisin on 04/04/2019.
//

import Foundation

extension Holome : HolomeViewControllerDelegate {
    func sendEvent(eventName: String) {
        if let callbackId = self.eventListeners[eventName] {
            guard let result = CDVPluginResult(status: CDVCommandStatus_OK) else { return }
            result.setKeepCallbackAs(true)
            commandDelegate!.send(result,
                                  callbackId:  callbackId)
            
            
        } else {
            return;
        }
    }
    
    /// Send delegate event back to Cordova
    ///
    /// - Parameter eventName - Name of event to listen for
    func sendEvent(eventName : String, data : [String : Any] = [:]) {//, data : [String : Any]?
        if let callbackId = self.eventListeners[eventName] {
            guard let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: data) else { return }
            result.setKeepCallbackAs(true)
            commandDelegate!.send(result,
                                  callbackId:  callbackId)
            
            
        } else {
            return;
        }
        
    }
    
    
}