//
//  AppDelegate.swift
//  Todoey
//
//  Created by Eric Castillo on 4/28/18.
//  Copyright © 2018 Eric Castillo. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)

        do {
            _ = try Realm()
        } catch {
            print("error initializing new realm, \(error)")
        }

        return true
    }
    
}

