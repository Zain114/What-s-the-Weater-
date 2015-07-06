//
//  HTMLTag.swift
//  What's the Weater?
//
//  Created by Zainuddin Qazi on 6/14/15.
//  Copyright (c) 2015 Zainuddin Qazi. All rights reserved.
//

import Foundation

class HTMLTag {
    
    var containsChild : Bool
    lazy var child = HTMLTag.createChild()
    var tagName : String
    var tagContent : String
    
    init(tagName : String, tagContent : String) {
        
        containsChild = false
        self.tagName = tagName
        self.tagContent = tagContent
        
    }
    
    class func createChild() -> HTMLTag {
        
        return HTMLTag(tagName: "temp", tagContent: "temp")
        
    }
    
}