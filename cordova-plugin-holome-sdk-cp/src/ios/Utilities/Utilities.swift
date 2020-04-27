//
//  Utilities.swift
//  HelloCordova
//
//  Created by Oisin on 09/04/2019.
//

import Foundation

extension UIColor {
    convenience init?(hexString:String) {
        var cString:String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return nil;
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue:CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha:1)
    }
    
}

/// MARK: String helper methods
extension String {
    
    func fileName() -> String {
        
        if let fileNameWithoutExtension = NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent {
            return fileNameWithoutExtension
        } else {
            return ""
        }
    }
    
    func fileExtension() -> String {
        
        if let fileExtension = NSURL(fileURLWithPath: self).pathExtension {
            return fileExtension
        } else {
            return ""
        }
    }
}


/// MARK: CGRect extenisons
extension CGRect {
    init(dictionary: Dictionary<String, Int>){
        let  x = dictionary["x"] ?? 0;
        let  y = dictionary["y"] ?? 0;
        let  height = dictionary["height"] ?? 150;
        let  width = dictionary["width"] ?? 150;
        self.init(x: x, y: y, width: width, height: height);
    }
}

/// MARK: CGPoint extenisons
extension CGPoint {
    init(dictionary: Dictionary<String, Int>){
        let  x = dictionary["x"] ?? 0;
        let  y = dictionary["y"] ?? 0;
        self.init(x: x, y: y);
    }
}

///MARK : HolomeSDK Extension
extension HolomeSDK.FocusSquare.Data {
    /// Convience init for the focus square with any defaults
    convenience init(data: [String : Any]){
        let size : Float = data["size"] as? Float ?? 0.17;
        let thickness : Float = data["thickness"] as? Float  ?? 0.018;
        let scaleForClosedSquare : Float = data["scaleForClosedSquare"] as? Float ?? 0.97;
        let sideLengthForOpenSegments : CGFloat = data["scaleForClosedSquare"] as? CGFloat ?? 0.2;
        let animationDuration : Double = data["animationDuration"]  as? Double ?? 0.7;
        let fillColor = UIColor(hexString: data["fillColor"] as? String ?? "" ) ?? #colorLiteral(red: 0.477065742, green: 0.8371616006, blue: 0.9758175015, alpha: 1);
        let primaryColor = UIColor(hexString: data["primaryColor"]  as? String ?? "" ) ?? #colorLiteral(red: 0.3002893329, green: 0.4696406722, blue: 0.8230944276, alpha: 1);
        var fillImage : UIImage? = nil;
        
        if let image = data["fillImage"] as? String {
        
            let path = FileManager.sharedInstance.getFilePath(file: image);
            fillImage = UIImage(contentsOfFile: path ?? "");
        }
        
        self.init(size:           size,
                  thickness:                 thickness,
                  scaleForClosedSquare:      scaleForClosedSquare,
                  sideLengthForOpenSegments: sideLengthForOpenSegments,
                  animationDuration:         animationDuration,
                  primaryColor: primaryColor,
                  fillColor:    fillColor,
                  fillImage: fillImage);
    }
}
