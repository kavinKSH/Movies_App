//
//  Date + Extensions.swift
//  Movies_App
//
//  Created by Kavin on 09/05/24.
//

import Foundation

extension Date {
    func convertDateFormet() -> String {
        return formatted(.dateTime.month().year())
    }
}

extension String {
    var convertedString: Date? {
        let dateFormeter = DateFormatter()
        dateFormeter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormeter.locale = Locale(identifier: "en_US_POSIX")
        dateFormeter.timeZone = .current
        return dateFormeter.date(from: self)
    }
}

extension Date {
    var convertSpecifiedDateFormet: String {
        let dateFormet = DateFormatter()
        dateFormet.dateFormat = "MMM-dd-yyyy"
        return dateFormet.string(from: self)
    }
}

extension String {
    func convertedDisplayFormet() -> String {
        guard let date = convertedString else {
            return "N/A"
        }
        return date.convertSpecifiedDateFormet
    }
}



extension String {
    var convertedStringKeywardMovies: Date? {
        let dateFormeter = DateFormatter()
        dateFormeter.dateFormat = "yyyy-MM-dd"
        return dateFormeter.date(from: self)
    }
}

extension Date {
    var convertSpecifiedDateFormetForKeywardMovies: String {
        let dateFormet = DateFormatter()
        dateFormet.dateFormat = "MMM yyyy"
        return dateFormet.string(from: self)
    }
}

extension String {
    func convertedDisplayFormetForKeywardMovies() -> String {
        guard let date = convertedStringKeywardMovies else {
            return "N/A"
        }
        return date.convertSpecifiedDateFormetForKeywardMovies
    }
}

