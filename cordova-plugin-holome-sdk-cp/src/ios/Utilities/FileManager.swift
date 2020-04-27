//
//  FileManager.swift
//  HelloCordova
//
//  Created by Oisin on 10/04/2019.
//

import Foundation
class FileManager {
    static let sharedInstance = FileManager();]
    
    func getFilePath(file: String) -> String? {
        let directory = file.getFileDirectory();
        let ext  = file.fileExtension()
        let file = file.fileName()
        let path = Bundle.main.path(forResource: file, ofType: ext, inDirectory: directory);
        
        return path;
    }
}
