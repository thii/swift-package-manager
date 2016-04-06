/*
 This source file is part of the Swift.org open source project

 Copyright 2015 - 2016 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

public struct URL {
    
    /// Parses the URL type of a git repository
    /// e.g. https://github.com/apple/swift returns "https"
    /// e.g. git@github.com:apple/swift returns "git"
    ///
    /// This is *not* a generic URI scheme parser!
    public static func scheme(url: String) -> String? {

        func prefixOfSplitBy(delimiter: String) -> String? {
            let (head, tail) = url.splitAround(delimiter)
            if tail == nil {
                //not found
                return nil
            }
            //found, return head
            //lowercase the "scheme", as specified by the URI RFC (just in case)
            return head.lowercased()
        }
        
        for delim in ["://", "@"] {
            if let found = prefixOfSplitBy(delim) {
                return found
            }
        }
        return nil
    }
}
