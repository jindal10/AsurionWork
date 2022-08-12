//
//  AppConstant.swift
//  AsurionCodingWork
//
//  Created by admin on 04/08/22.
//

import Foundation


struct WebServiceName {
    static let petList = "https://api.npoint.io/a320a64c979acdcd0afa"
    static let configList = "https://api.npoint.io/12f8ed5f987dd1c01048"
}

enum AlertMessage: String {
    case workHoursEnded
    case workHoursOpen
    case configApiFail
    case petListPaiFail
    
    func message() -> String {
        switch self {
        case .workHoursEnded: return "Thank you for getting in touch with us. We’ll get back to you as soon as possible"
        case .workHoursOpen: return "Work hours has ended. Please contact us again on the next work day"
        case .configApiFail: return "Congif api fail"
        case.petListPaiFail: return "Pet List api fail"
        }
    }
}

struct StringConstant {
    static let officeHours = "Office Hours: "
    static let unableDequeueCell = "unable to dequeue cell"
    static let okay = "Okay"
}

struct DateFormatterType {
    static let serverDate = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    static let timeFormat = "HH:mm"
}
