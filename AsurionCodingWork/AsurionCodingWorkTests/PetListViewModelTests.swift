//
//  PetListViewModelTests.swift
//  AsurionCodingWorkTests
//
//  Created by Gaurav Jindal on 03/08/22.
//

import XCTest
@testable import AsurionCodingWork

class PetListViewModelTests: XCTestCase {
    var viewModel: PetListViewModel!

    override func setUp() async throws {
        viewModel = PetListViewModel()
    }
   
    func testGetNumberOfRows() {
        let model = PetModel(imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1200px-Cat_poster_1.jpg", title: "Cat", contentUrl: "https://en.wikipedia.org/wiki/Cat", dateAdded: "2018-06-02T03:27:38.027Z")
        viewModel.petDataArray.append(model)
        let rowCount = viewModel.getNumberOfRows()
        XCTAssert(rowCount != 0)
        XCTAssertTrue(rowCount != 0)
        XCTAssertEqual(rowCount, 1)
    }

    func testImageForGivenIndex() {
       let imageUrl = viewModel.getimage(index: 0)
        XCTAssert(imageUrl == nil)
        XCTAssertTrue(imageUrl == nil)
        XCTAssertEqual(imageUrl, nil)

        let model = PetModel(imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1200px-Cat_poster_1.jpg", title: "Cat", contentUrl: "https://en.wikipedia.org/wiki/Cat", dateAdded: "2018-06-02T03:27:38.027Z")
        viewModel.petDataArray.append(model)

        let newImageUrl = viewModel.getimage(index: 0)
        XCTAssert(newImageUrl == "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1200px-Cat_poster_1.jpg")
        XCTAssertTrue(newImageUrl != nil)
        XCTAssertEqual(newImageUrl, "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1200px-Cat_poster_1.jpg")
    }
    
    func testWorkingHours() {
        let model = PetModel(imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Cat_poster_1.jpg/1200px-Cat_poster_1.jpg", title: "Cat", contentUrl: "https://en.wikipedia.org/wiki/Cat", dateAdded: "2018-06-02T03:27:38.027Z")
        viewModel.petDataArray.append(model)
        let workingHour = viewModel.isWorkingHourOpen(for: IndexPath(row: 0, section: 0))
        XCTAssertFalse(workingHour)
    }
    
    func testPetListData() {
        let expectation = self.expectation(description: "test pet list data")
        viewModel.fetchPetData { success, error in
            XCTAssertTrue(success)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
        XCTAssertTrue(viewModel.petDataArray.count != 0)
    }
}
