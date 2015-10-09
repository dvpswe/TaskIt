//
//  Date.swift
//  TaskIt
//
//  Created by Darryl Pendergrass on Oct/6/15.
//  Copyright © 2015 Phoenix Media Services, LLC. All rights reserved.
//

import Foundation

class Date {
    
    class func from (year year:Int, month: Int, day: Int) -> NSDate{
        
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        let gregorianCalendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let date = gregorianCalendar?.dateFromComponents(components)
        return date!
    }
    
    class func toString(date date:NSDate) -> String {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateStringFormatter.stringFromDate(date)
        return dateString
    }
}