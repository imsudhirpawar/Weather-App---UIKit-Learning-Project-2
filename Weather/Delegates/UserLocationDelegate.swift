//
//  UserLocationDelegate.swift
//  Weather
//
//  Created by Sudhir Pawar on 20/09/23.
//

import Foundation
protocol UserLocationDelegate: AnyObject {
    func didReceivedLocation(userLocationString: String)
}

protocol CustomLocationDelegate: AnyObject {
    func didReceivedCustomLocation(userLocationString: String)
}


