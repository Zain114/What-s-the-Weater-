//
//  ViewController.swift
//  What's the Weater?
//
//  Created by Zainuddin Qazi on 5/17/15.
//  Copyright (c) 2015 Zainuddin Qazi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {


/*************Variables*************/
    
    var location: NSString
    var isZipcode: Bool
    var urlString: String
    var url: NSURL
    var parser : HTMLParser?
    
/*************IB Outlets*************/
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var detailedTextView: UITextView!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    
/*************Updating Func*************/

    func displayWeatherResults(spanTag : HTMLNode) {
        
        tempLabel.text = spanTag.contents
        
    }

/*************HTML Func*************/
    
    func retrieveHTMLData() {
        
        println("retrieveHTMLData")
        
        urlString = "http://www.weather-forecast.com/locations/" + locationTextField.text + "/forecasts/latest"
        url = NSURL(string: urlString)!
        
        
        //go to webaddress
        var URLSession = NSURLSession.sharedSession()
        var URLSessionTask = URLSession.dataTaskWithURL(url) {
            (data, response, error) in
            
            if error == nil {
                
                var dataInUTF = NSString(data: data, encoding: NSUTF8StringEncoding)
    
                var err : NSError?
                self.parser = HTMLParser(html: dataInUTF! as String, error: &err)
                if(err != nil) {
                    
                    //print(err)
                    
                }
                    
                var body = self.parser!.body
                if let spanTag = body?.findChildTagAttr("span", attrName: "class", attrValue: "phrase"){
                    
                    print("Successfully reading")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                    
                        self.displayWeatherResults(spanTag)
                        
                    }
                    
                }
                
            } else {
                
                println("ERROR: URL not valid")
                
                self.HTMLErrorDialog()
                
            }
            
        }
        
        URLSessionTask.resume()
        
    }
    

/*************Delegate Func*************/

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == locationTextField {
        
            location = locationTextField.text
            
            if let containtInt = String(location).toInt() {
                
                isZipcode = true
                
            }
            
            NSNotificationCenter.defaultCenter().postNotificationName("retrieveHTMLDataa", object: nil)
            
        }
        
        textField.resignFirstResponder()
        return true
        
    }
    

/*************Error Handling*************/
    
    func HTMLErrorDialog() {
        
        var errorAlert = UIAlertController(title: "Error", message: "URL: " + self.urlString + " is not valid", preferredStyle: UIAlertControllerStyle.ActionSheet)
        errorAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(errorAlert, animated: true, completion: nil)
        
    }
    
    
/*************View Controller*************/
    
    
    required init(coder aDecoder: NSCoder) {
        
        location = ""
        isZipcode = false
        urlString = ""
        url = NSURL(string: urlString)!
        
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationTextField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("retrieveHTMLData"), name: "retrieveHTMLDataa", object: nil)
        
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

