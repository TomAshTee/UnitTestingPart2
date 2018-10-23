//
//  PhotoViewControllerTests.swift
//  photolodeTests
//
//  Created by Tomasz Jaeschke on 22/10/2018.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import XCTest
@testable import photolode

class PhotoViewControllerTests: XCTestCase {

    var sut: PhotoViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        sut = nil
    }
    
    func testPhotoDownload_ImageOrientationIsIdentical(){
        let expectedImageOrientation = UIImage(named: "pexels-photo-768218")?.imageOrientation
        guard let url = URL(string: imageURLStrings[3]) else {
            XCTFail()
            return
        }
        let sessionAnsweredExpectation = expectation(description: "Session")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
                return
            }
            if let data = data {
                guard let image = UIImage(data: data) else {
                    XCTFail()
                    return
                }
                XCTAssertEqual(image.imageOrientation, expectedImageOrientation)
                sessionAnsweredExpectation.fulfill()
            }
        }.resume()
        
        waitForExpectations(timeout: 10, handler: nil)
    }

}
