//
//  XCTestCase+FailableDeleteSpecs.swift
//  EssentialFeedTests
//
//  Created by Evgenii Iavorovich on 2/16/25.
//

import XCTest
import EssentialFeed

extension FailableDeleteSpecs where Self: XCTestCase {
    func assertThatDeleteDeliversErrorOnDeletionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        let deletionError = deleteCache(from: sut)

        XCTAssertNotNil(deletionError, "Expected cache deletion to fail", file: file, line: line)
    }

    func assertThatDeleteHasNoSideEffectsOnDeletionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
        deleteCache(from: sut)

        expect(sut, toRetreive: .success(.none), file: file, line: line)
    }
}
