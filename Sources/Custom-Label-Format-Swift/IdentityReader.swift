//
//  IdentityReader.swift
//  
//
//  Created by Justin White on 4/09/21.
//

import Foundation

protocol IdentityReader {
    func readFile(source: String) -> [String:String]
    
    func identityMapFromString(input: String) -> [String : String]
}

class FileIdentityReader: IdentityReader {
    
    private let expectedFileType = "identity"
    
    func readFile(source: String) -> [String : String] {
        
        let pathExtension = (source as NSString).pathExtension
        
        if pathExtension != expectedFileType {
            return [:]
        }
        
        do {
            let data = try String(contentsOfFile: source)
            return identityMapFromString(input: data)
        }
        catch {
            print(error)
            return [:]
        }
    }
    
    func identityMapFromString(input: String) -> [String : String] {
        do {
            guard let data = input.data(using: .utf8),
                  let value = try JSONSerialization
                        .jsonObject(with: data, options: []) as? [String: String] else {
                return [:]
            }
            
            return value
        }
        catch {
            print(error)
            return [:]
        }
    }
}