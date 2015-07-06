//
//  HTMLParser.swift
//  What's the Weater?
//
//  Created by Zainuddin Qazi on 5/20/15.
//  Copyright (c) 2015 Zainuddin Qazi. All rights reserved.
//

import Foundation

class HTMLParser {

    var tagMatchingRegExString = "<+/*[a-z0-9]*>" //"<[a-z](\\d*|[a-z]*)\\\\?>"

    
    func makeHTMLDictionary(HTMLcontent: NSString) -> NSDictionary {
    
        var HTMLDictionary: NSDictionary = NSDictionary()
        /* 

        HTML Dictionary Structure:
    
        {
            <head>  : [head content]
                        (parent of, child of)
            <title> : [title content]
                        (parent of, child of)
            .
            .
            .
        }

        */
        
        //find all matches
        var regEx = NSRegularExpression(pattern: tagMatchingRegExString, options: NSRegularExpressionOptions.CaseInsensitive, error: nil)
        var matches = regEx!.matchesInString(HTMLcontent as String, options: nil, range: NSRange(location: 0, length: HTMLcontent.length)) as! [NSTextCheckingResult]
    
        //loop through matches and make dictionary of tags
        
    
        return HTMLDictionary
    
    }
    
    
    func makeHTMLTags(tagCheckingResults : [NSTextCheckingResult], HTMLContent : NSString) -> NSDictionary {
        
        var HTMLDictionary: NSDictionary = NSDictionary()
        /*
        
        HTML Dictionary Structure:
        
        {
        <head>  : [head content]
        (parent of, child of)
        <title> : [title content]
        (parent of, child of)
        .
        .
        .
        }
        
        */
        
        for result in tagCheckingResults {
            
            var tagName = "temp"
            var tagContent = "temp"
            
            tagName = HTMLContent.substringWithRange(tagCheckingResult.range)
            
            
            
        }
        
        return HTMLDictionary
        
    }

    /*
    func findHTMLTagRanges(HTMLcontent: NSString) -> NSRange {
    
    
    
    }
    */

}