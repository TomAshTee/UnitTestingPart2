//
//  PhotoViewControllerTests.swift
//  photolodeTests
//
//  Created by Caleb Stultz on 1/10/18.
//  Copyright © 2018 Caleb Stultz. All rights reserved.
//

import XCTest
@testable import photolode

class PhotoViewControllerTests: XCTestCase {
    
    var sut: PhotoViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "PhotoViewController") as! PhotoViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testPhotoDownload_ImageOrientationIsIdentical() {
        let expectedImageOrientation = UIImage(named: "pexels-photo-768218")?.imageOrientation
        
        guard let url = URL(string: imageURLStrings[3]) else { XCTFail(); return }
        let sessionAnsweredExpectation = expectation(description: "Session")
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            
            if let data = data {
                guard let image = UIImage(data: data) else { XCTFail(); return }
                sessionAnsweredExpectation.fulfill()
                XCTAssertEqual(image.imageOrientation, expectedImageOrientation)
            }
        }.resume()
        
        waitForExpectations(timeout: 8, handler: nil)
    }
    
}










