//
//  DateHelper.swift
//  news-app
//
//  Created by huseyin on 17.07.2023.
//

import Foundation

extension String {
    func getTimeAgo() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let formattedDate = dateFormatter.date(from: self)
        guard let formatDate = formattedDate else {return "a moment ago"}
        
        let interval = Calendar.current.dateComponents([.hour,.minute,.day], from: formatDate,to: Date())
        if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + "h ago" :
                "\(hour)" + "h ago"
        } else if let minute = interval.minute, minute > 0  {
            return minute == 1 ? "\(minute)" + "m ago" :
                "\(minute)" + "m ago"
        } else if let day = interval.day, day > 0  {
            return day == 1 ? "\(day)" + "d ago" :
                "\(day)" + "d ago"
        } else {
            return "a moment ago"
        }
    }
}
