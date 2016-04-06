/*
 This source file is part of the Swift.org open source project

 Copyright 2015 - 2016 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/

@testable import Utility
import XCTest

class StringTests: XCTestCase {

    func testTrailingChomp() {
        XCTAssertEqual("abc\n".chomp(), "abc")
        XCTAssertEqual("abc\r\n".chomp(), "abc")
        XCTAssertEqual("abc\r\n\r\n".chomp(), "abc")
        XCTAssertEqual("abc\r\n\r\r\n".chomp(), "abc\r\n\r")
        XCTAssertEqual("abc\n \n".chomp(), "abc\n ")
    }
    
    func testSeparatorChomp() {
        XCTAssertEqual("abc".chomp("c"), "ab")
        XCTAssertEqual("abc\n".chomp("c"), "abc\n")
        XCTAssertEqual("abc\n c".chomp("c"), "abc\n ")
    }

    func testEmptyChomp() {
        XCTAssertEqual("".chomp(), "")
        XCTAssertEqual(" ".chomp(), " ")
        XCTAssertEqual("\n\n".chomp(), "")
    }

    func testChuzzle() {
        XCTAssertNil("".chuzzle())
        XCTAssertNil(" ".chuzzle())
        XCTAssertNil(" \t ".chuzzle())
        XCTAssertNil(" \t\n".chuzzle())
        XCTAssertNil(" \t\r\n".chuzzle())
        XCTAssertEqual(" a\t\r\n".chuzzle(), "a")
        XCTAssertEqual("b".chuzzle(), "b")
    }
    
    func testSplitAround() {
        
        func eq(lhs: (String, String?), _ rhs: (String, String?), file: StaticString = #file, line: UInt = #line) {
            XCTAssertEqual(lhs.0, rhs.0, file: file, line: line)
            XCTAssertEqual(lhs.1, rhs.1, file: file, line: line)
        }
        
        eq("".splitAround("::"), ("", nil))
        eq("foo".splitAround("::"), ("foo", nil))
        eq("foo::".splitAround("::"), ("foo", ""))
        eq("::bar".splitAround("::"), ("", "bar"))
        eq("foo::bar".splitAround("::"), ("foo", "bar"))
    }
}

class URLTests: XCTestCase {

    func testSchema() {
        XCTAssertEqual(Utility.URL.scheme("http://github.com/foo/bar"), "http")
        XCTAssertEqual(Utility.URL.scheme("https://github.com/foo/bar"), "https")
        XCTAssertEqual(Utility.URL.scheme("HTTPS://github.com/foo/bar"), "https")
        XCTAssertEqual(Utility.URL.scheme("git@github.com/foo/bar"), "git")
        XCTAssertEqual(Utility.URL.scheme("ssh@github.com/foo/bar"), "ssh")
        XCTAssertNil(Utility.URL.scheme("github.com/foo/bar"))
        XCTAssertNil(Utility.URL.scheme("user:/github.com/foo/bar"))
    }
}
