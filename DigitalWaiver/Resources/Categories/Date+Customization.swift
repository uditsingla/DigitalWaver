//
//  Date+Customization.swift
//  
//
//  Created by Apple on 07/06/17.
//  Copyright © 2017 Abhishek Singla. All rights reserved.
//

import Foundation

let dateTimeFormat = "E, d MMM yy h:mm a"
let dateFormat = "d MMM yy"
let timeFormat = "h:mm a"

extension NSDate{
    
    class func getDateFormatter(timeZone :String,dateFormat : String) -> DateFormatter
    {
        let srvrTimeZone = NSTimeZone.init(name: timeZone)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = srvrTimeZone as TimeZone!
        dateFormatter.dateFormat = dateFormat
        return dateFormatter
    }
    
   class func calculateDateTimeString(timeZone : String,tripTimeStamp : Double) -> String
    {
      
        let dateFormatterSrvrTimZone = NSDate.getDateFormatter(timeZone: timeZone, dateFormat: dateTimeFormat)
        
        // let the system convert the date to utc
        let stringDateTime = dateFormatterSrvrTimZone.string(from: NSDate(timeIntervalSince1970:tripTimeStamp as TimeInterval) as Date)
        
        return stringDateTime
   
    }
    
    
   class func getDateComponentForDate(stringDateTime : String, timeZone : String)-> String
    {
       
        let dateFormatter = NSDate.getDateFormatter(timeZone: timeZone,dateFormat: dateTimeFormat)
        
        // let the system convert the date to utc as from date any type of string can be created
        let date = dateFormatter.date(from: stringDateTime)
        
        let dateFormatterDate = NSDate.getDateFormatter(timeZone: timeZone,dateFormat: dateFormat)
        
        return dateFormatterDate.string(from: date!)
    }

  class func getTimeComponentForDate(stringDateTime : String,timeZone : String) -> String
    {
        let dateFormatter = NSDate.getDateFormatter(timeZone: timeZone,dateFormat: dateTimeFormat)
        
        // let the system convert the date to utc

        let date = dateFormatter.date(from: stringDateTime)
        
        let dateFormatterTime = NSDate.getDateFormatter(timeZone: timeZone,dateFormat: timeFormat)
        
        return dateFormatterTime.string(from: date!)

    }
    
    class func getDateObj(formaterType : String, dateString : String) -> Date
    {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateFormatter.timeZone = NSTimeZone.system
        let strDt = dateFormatter.string(from: NSDate() as Date)
        dateFormatter.dateFormat = formaterType       
        return dateFormatter.date(from: strDt+" "+dateString)!
    }
    
    
    class func getCurrentDateString(formatterType : String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatterType
        let strDt = dateFormatter.string(from: NSDate() as Date)
        return strDt
    }
    
    /*
    func getDayName(dateObj : Date) -> (String?,String?,String?){
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: dateObj)
        
        let year =  components.year
        let month = components.month
        let day = components
        
        return (year,month,day)
    }
    */
  func isBetweeen(date date1: NSDate, andDate date2: NSDate) -> Bool {
        return date1.compare(self as Date) == self.compare(date2 as Date)
    }
   
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        return dateFormatter.string(from: self as Date).capitalized
        // or capitalized(with: locale)
    }
    
}
