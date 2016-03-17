//
//  Lieu.swift
//  VoyageVoyages
//
//  Created by arthur jamelot on 24/02/2016.
//  Copyright © 2016 arthur jamelot et charles bordier. All rights reserved.
//

import Foundation

enum ErrorLieu: ErrorType {
    case DateWrongFormat
}

class Lieu {
    private var dateCacheeLieu: NSDate?
    private var nameCacheLieu: String?
    var nameLieu: String? {
        get {return self.nameCacheLieu}
        set {
            guard let unnom=newValue where !unnom.isEmpty else {
                self.nameCacheLieu=nil
                return
            }
            self.nameCacheLieu=newValue
        }
    }
    var dateLieu: String? {
        get {
            guard let uneDate = dateCacheeLieu else {
                return nil
            }
            return dateStringFormatter.stringFromDate(uneDate)
        }
        set {
            guard let uneDate = newValue where !uneDate.isEmpty else {
                self.dateCacheeLieu = nil
                return
            }
            self.dateCacheeLieu = dateStringFormatter.dateFromString(uneDate)
        }
    }
    let dateStringFormatter = NSDateFormatter()
    
    init(nomLieu: String?, date: String?) {
        self.nameLieu = nomLieu
        dateStringFormatter.dateFormat = "yyyy/MM/dd"
        self.dateLieu = date
    }
}