//
//  TestInternet.swift
//  NJIT Student Guide
//
//  Created by user113232 on 10/27/15.
//  Copyright © 2015 Fantastic4. All rights reserved.
//

import Foundation

    public class TestInternet{
        class func isConnected() ->Bool{
            
            let Status:Bool = true
            let url = NSURL(string: "http://google.com/")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "HEAD"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
            request.timeoutInterval = 10.0
            
            var response: NSURLResponse?
        
            do
            {
            _ = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response) as NSData?
            }catch _ as NSError{
                return false;
            }
            
            return Status
        }
    }
