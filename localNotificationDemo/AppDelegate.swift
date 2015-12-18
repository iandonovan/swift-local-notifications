//
//  AppDelegate.swift
//  localNotificationDemo
//
//  Created by Smashing Boxes on 12/18/15.
//  Copyright © 2015 Smashing Boxes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    let notificationSettings = UIUserNotificationSettings(forTypes: .Alert, categories: nil)
    application.registerUserNotificationSettings(notificationSettings)
    generateLocalNotification()
    return true
  }
  
  func generateLocalNotification() {
    let localNotification = UILocalNotification()
    localNotification.fireDate = NSDate(timeIntervalSinceNow: 10)
    localNotification.alertBody = "My first local notification"
    localNotification.applicationIconBadgeNumber = 1
    localNotification.soundName = UILocalNotificationDefaultSoundName
    let userInfo: [String: AnyObject] = ["id": 42]
    localNotification.userInfo = userInfo
    UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
  }
  
  func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
    if application.applicationState == UIApplicationState.Active {
      // Inside app
      let alertController = UIAlertController(title: "Notification", message: notification.alertBody, preferredStyle: .Alert)
      let ignoreAction = UIAlertAction(title: "Ignore", style: .Cancel, handler: { _ in print("Ignore") })
      let viewAction = UIAlertAction(title: "View", style: .Default, handler: { _ in self.takeActionWithLocalNotification(notification) })
      alertController.addAction(ignoreAction)
      alertController.addAction(viewAction)
      self.window?.rootViewController?.presentViewController(alertController, animated: true, completion: {})
    } else {
      // Outside app
      self.takeActionWithLocalNotification(notification)
    }
  }
  
  func takeActionWithLocalNotification(localNotification: UILocalNotification) {
    let notificationId = localNotification.userInfo?["id"] as! Int
    let alertController = UIAlertController(title: "Action Taken", message: "We are viewing notification \(notificationId)", preferredStyle: .Alert)
    let okAction = UIAlertAction(title: "OK", style: .Default, handler: { _ in print("OK") })
    alertController.addAction(okAction)
    self.window?.rootViewController?.presentViewController(alertController, animated: true, completion: {})
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

