//
//  AppDelegate.swift
//  tips
//
//  Created by Olga Azarova on 1/8/15.
//  Copyright (c) 2015 Olga Azarova. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var backgroundEnterDate: NSDate!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        backgroundEnterDate = NSDate()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        let calendar = NSCalendar.currentCalendar()
        let comps = NSDateComponents()
        comps.minute = 10
        let dateEntered = calendar.dateByAddingComponents(comps, toDate: backgroundEnterDate, options: NSCalendarOptions.allZeros)
        var defaults = NSUserDefaults.standardUserDefaults()
        
        if NSDate().compare(dateEntered!) == NSComparisonResult.OrderedDescending
        {
            NSLog("after 10 minutes");
            defaults.setBool(true, forKey: "reset_necessary")
        } else if NSDate().compare(dateEntered!) == NSComparisonResult.OrderedAscending
        {
            NSLog("within 10 minutes");
            defaults.setBool(false, forKey: "reset_necessary")
        }
        defaults.synchronize()

    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        if (backgroundEnterDate != nil){
            let calendar = NSCalendar.currentCalendar()
            let comps = NSDateComponents()
            comps.second = 1
            let dateEntered = calendar.dateByAddingComponents(comps, toDate: backgroundEnterDate, options: NSCalendarOptions.allZeros)
            var defaults = NSUserDefaults.standardUserDefaults()
            
            if NSDate().compare(dateEntered!) == NSComparisonResult.OrderedDescending
            {
                NSLog("after 10 minutes");
                defaults.setBool(true, forKey: "reset_necessary")

            } else if NSDate().compare(dateEntered!) == NSComparisonResult.OrderedAscending
            {
                NSLog("within 10 minutes");
                defaults.setBool(false, forKey: "reset_necessary")
            }
            defaults.synchronize()
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

