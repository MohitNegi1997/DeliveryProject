//
//  StringExtension.swift
//  DemoProject
//
//  Created by Mohit on 29/11/20.
//  Copyright © 2020 Mohit. All rights reserved.
//

import Foundation
import UIKit

extension String {
        
    ///Removes all spaces from the string
    var removeSpaces:String{
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    //Mask the email
    var getSecureEmail:String {
        if self.contains("@") {
            let part = self.components(separatedBy: "@")
            let newText = String(part[0].enumerated().map { index, char in
                return [0, 1].contains(index) ? char : "x"
            })
            return newText + "@" + part[1]
        }
        return self
    }
    
    ///Returns a localized string
    var localized:String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    ///Removes leading and trailing white spaces from the string
    var byRemovingLeadingTrailingWhiteSpaces:String {
        let spaceSet = CharacterSet.whitespaces
        return self.trimmingCharacters(in: spaceSet)
    }
    
    var byRemovingLeadingTrailingWhiteSpacesandNewLines: String {
        let spaceSet = CharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: spaceSet)
    }
    
    public func trimTrailingWhitespace() -> String {
        if let trailingWs = self.range(of: "\\s+$", options: .regularExpression) {
            return self.replacingCharacters(in: trailingWs, with: "")
        } else {
            return self
        }
    }
    
    ///Returns 'true' if the string is any (file, directory or remote etc) url otherwise returns 'false'
    var isAnyUrl:Bool{
        return (URL(string:self) != nil)
    }
    
    ///Returns the json object if the string can be converted into it, otherwise returns 'nil'
    var jsonObject:Any? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        return nil
    }
    
    ///Returns the base64Encoded string
    var base64Encoded:String {
        return Data(self.utf8).base64EncodedString()
    }
    
    ///Returns the string decoded from base64Encoded string
    var base64Decoded:String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func localizedString(lang:String) ->String {
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    ///Returns 'true' if string contains the substring, otherwise returns 'false'
    func contains(s: String) -> Bool {
        return self.range(of: s) != nil ? true : false
    }
    
    ///Replaces occurances of a string with the given another string
    func replace(string: String, withString: String) -> String {
        return self.replacingOccurrences(of: string, with: withString, options: String.CompareOptions.literal, range: nil)
    }
    
    ///Converts the string into 'Date' if possible, based on the given date format and timezone. otherwise returns nil
    func toDate(dateFormat:String,timeZone:TimeZone = TimeZone.current)->Date?{
        let frmtr = DateFormatter()
        frmtr.locale = Locale(identifier: "en_US_POSIX")
        frmtr.dateFormat = dateFormat
        frmtr.timeZone = timeZone
        return frmtr.date(from: self)
    }
    
    func toDateText(inputDateFormat: String, outputDateFormat: String, timeZone: TimeZone = TimeZone.current) -> String{
        if let date = self.toDate(dateFormat: inputDateFormat, timeZone: timeZone) {
            return date.toString(dateFormat: outputDateFormat, timeZone: timeZone)
        } else {
            return ""
        }
    }
    
    func checkIfValid(_ validityExression : ValidityExression) -> Bool {
        let regEx = validityExression.rawValue
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: self)
    }
    
    // remove Multiple Spaces And New Lines
    var condensedWhitespace: String {
        let components = self.components(separatedBy: NSCharacterSet.whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
    ///Capitalize the very first letter of the sentence.
    var capitalizedFirst: String {
        guard !isEmpty else { return self }
        var result = self
        let substr1 = String(self[startIndex]).uppercased()
        result.replaceSubrange(...startIndex, with: substr1)
        return result
    }
    
    func stringByAppendingPathComponent(path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    
    public var isAlphaNumeric: Bool {
        let hasLetters = rangeOfCharacter(from: .letters, options: .numeric, range: nil) != nil
        let hasNumbers = rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
        let comps = components(separatedBy: .alphanumerics)
        return comps.joined(separator: "").count == 0 && hasLetters && hasNumbers
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted)  == nil
    }
}
