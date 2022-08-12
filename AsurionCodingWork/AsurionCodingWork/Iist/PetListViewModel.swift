//
//  PetListViewModel.swift
//  AsurionCodingWork
//
//  Created by Gaurav Jindal on 02/08/22.
//

import UIKit

class PetListViewModel {

    var petDataArray: [PetModel] = []
    private var configuration: ConfigModel?
    private let headerHeight: CGFloat = 180
    private let headerHeightWithotAction: CGFloat = 100
    func getNumberOfRows() -> Int {
        return petDataArray.count
    }
    
    func getHeightOfHeader() -> CGFloat {
        if getNumberOfRows() > 0 {
            if !isCallEnable() && !isChatEnable() {
                return headerHeightWithotAction
            }
            return headerHeight
        }
        return 0
    }
    
    func getimage(index: Int) -> String? {
        if index < petDataArray.count {
            return petDataArray[index].imageUrl
        } 
        return nil
    }
    
    func getPetName(index: Int) -> String? {
        if index < petDataArray.count {
            return petDataArray[index].title
        } 
        return nil
    }
    
    func getDateAdded(index: Int) -> String? {
        if index < petDataArray.count {
            return petDataArray[index].dateAdded
        } 
        return nil
    }
    
    func getContentUrl(index: Int) -> String? {
        if index < petDataArray.count {
            return petDataArray[index].contentUrl
        } 
        return nil
    }

    func fetchPetData(completionHandler: @escaping DataParsedCompletionHandler) {
        if let petListUrl = URL(string: WebServiceName.petList) {
            NetworkClient.sharedClient.get(url: petListUrl) { [weak self] (success, response, error) in
                if success {
                    if let data = response as? Data {
                        if let modelArray = self?.getModelFromData(data) {
                            self?.petDataArray = modelArray
                        }
                    } 
                    completionHandler(success, nil)
                } else {
                    completionHandler(false, error)
                }
            } 
        }
    } 
    
    func getModelFromData(_ data: Data?) -> [PetModel]? {
        if let data = data {
            let decoder = JSONDecoder()
            if let jsonModel = try? decoder.decode(Pets.self, from: data) {
                return jsonModel.pets
            }
        } 
        return nil
    }   
    
    func geConfigData(completionHandler: @escaping DataParsedCompletionHandler) {
        if let configUrl = URL(string: WebServiceName.configList) {
            NetworkClient.sharedClient.get(url: configUrl) { [weak self] (success, response, error) in
                if success {
                    if let data = response as? Data {
                        if let jsonModel = try? JSONDecoder().decode(Setting.self, from: data) {
                            self?.configuration = jsonModel.settings
                        }
                    } 
                    completionHandler(success, nil)
                } else {
                    completionHandler(false, error)
                }
            } 
        }
    }
    
    func isCallEnable() -> Bool {
        return configuration?.isCallEnabled ?? false
    }
    
    func isChatEnable() -> Bool {
        return configuration?.isChatEnabled ?? false
    }
    
    func getWorkingHours() -> String {
        return StringConstant.officeHours + (configuration?.workHours ?? "")
    }
    
    //MMARK: Date conversion
    private func getSelectedDate(indexPath: IndexPath) -> Date? {
        if let dateString =  getDateAdded(index: indexPath.row) {
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormatterType.serverDate
            if let date = formatter.date(from: dateString) {
                return date
            }
        }
        return nil
    }
    
    private func isDayCorrect(date: Date) -> Bool {
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: date)
        // restrict weekend days
        if weekDay != 7 && weekDay != 1 {
            return true
        }
        return false
    }
    
    private func isHourCorrect(date: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatterType.timeFormat
        let selectedHour = dateFormatter.string(from: date).replacingOccurrences(of: ":", with: ".")
        
        let hours = getWorkingHours()
        let array = hours.components(separatedBy: " ")
        
        if array.count == 4 {
            let startingHour: Double = Double(array[1].replacingOccurrences(of: ":", with: ".")) ?? 0.0
            let closingHour: Double = Double(array[3].replacingOccurrences(of: ":", with: ".")) ?? 0.0
            if let hr = Double(selectedHour) {
                if hr < closingHour && hr > startingHour {
                    return true
                }
            }
        }
        return false
    }
    
    func isWorkingHourOpen(for indexPath : IndexPath) -> Bool {
        if let date = getSelectedDate(indexPath: indexPath) {
//            guard isDayCorrect(date: date) else {
//                return false
//            }
            guard isHourCorrect(date: date) else {
                return false
            }
            return true             
        }
        return false
    }
}
