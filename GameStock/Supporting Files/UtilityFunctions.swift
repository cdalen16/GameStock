//
//  UtilityFunctions.swift
//  GameStock
//
//  Created by CS3714 on 4/25/21.
//  Copyright © 2021 GameStock. All rights reserved.
//

import Foundation
import SwiftUI
/*
**************************
MARK: - Get Image from URL
**************************
*/
public func getImageFromUrl(url: String, defaultFilename: String) -> Image {
    /*
     If getting image from URL fails, Image file with given defaultFilename
     (e.g., "ImageUnavailable") in Assets.xcassets will be returned.
     */
    var imageObtainedFromUrl = Image(defaultFilename)
 
    let headers = [
        "accept": "image/jpg, image/jpeg, image/png",
        "cache-control": "cache",
        "connection": "keep-alive",
    ]
 
    // Convert given URL string into URL struct
    guard let imageUrl = URL(string: url) else {
        return Image(defaultFilename)
    }
 
    let request = NSMutableURLRequest(url: imageUrl,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 30.0)
 
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
 
    /*
     Create a semaphore to control getting and processing image data.
     signal() -> Int    Signals (increments) a semaphore.
     wait()             Waits for, or decrements, a semaphore.
     */
    let semaphore = DispatchSemaphore(value: 0)
 
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
        URLSession is established and the image file from the URL is set to be fetched
        in an asynchronous manner. After the file is fetched, data, response, error
        are returned as the input parameter values of this Completion Handler Closure.
        */
 
        // Process input parameter 'error'
        guard error == nil else {
            semaphore.signal()
            return
        }
 
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            semaphore.signal()
            return
        }
 
        // Unwrap Optional 'data' to see if it has a value
        guard let imageDataFromUrl = data else {
            semaphore.signal()
            return
        }
 
        // Convert fetched imageDataFromUrl into UIImage object
        let uiImage = UIImage(data: imageDataFromUrl)
 
        // Unwrap Optional uiImage to see if it has a value
        if let imageObtained = uiImage {
            // UIImage is successfully obtained. Convert it to SwiftUI Image.
            imageObtainedFromUrl = Image(uiImage: imageObtained)
        }
 
        semaphore.signal()
    }).resume()
 
    /*
     The URLSession task above is set up. It begins in a suspended state.
     The resume() method starts processing the task in an execution thread.
 
     The semaphore.wait blocks the execution thread and starts waiting.
     Upon completion of the task, the Completion Handler code is executed.
     The waiting ends when .signal() fires or timeout period of 30 seconds expires.
    */
 
    _ = semaphore.wait(timeout: .now() + 30)
 
    return imageObtainedFromUrl
}
