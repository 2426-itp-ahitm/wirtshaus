//
//  EmployeeViewModel.swift
//  iOS
//
//  Created by Alexander Hahn on 05.05.25.
//

import Foundation
import SwiftUICore

class ShiftViewModel: ObservableObject {
    @Published var shifts: [Shift] = []
    
    var companyId: Int

    init(companyId: Int) {
        self.companyId = companyId
        loadShiftsAsync() {}
    }

    private func load() -> [Shift] {
        var shifts: [Shift] = []
        let jsonDecoder = JSONDecoder()

        guard let url = URL(string: "http://localhost:8080/api/\(companyId)/shifts") else {
            print("Invalid URL")
            return shifts
        }

        if let data = try? Data(contentsOf: url) {
            if let loadedShifts = try? jsonDecoder.decode([Shift].self, from: data) {
                shifts = loadedShifts
                print("Shifts loaded: \(shifts.count)")
            } else {
                print("Failed to decode shifts")
            }
        } else {
            print("Failed to load data from URL")
        }

        return shifts
    }

    private func loadShiftsAsync(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            let loadedShifts = self.load()
            DispatchQueue.main.async {
                self.shifts = loadedShifts
                completion()
            }
        }
    }

    func count() -> Int {
        return shifts.count
    }

    func shiftStartTime(by id: Int) -> String {
        return shifts.first(where: { $0.id == id })?.startTime ?? "-1"
    }

    func shiftEndTime(by id: Int) -> String {
        return shifts.first(where: { $0.id == id })?.endTime ?? "-1"
    }

}
