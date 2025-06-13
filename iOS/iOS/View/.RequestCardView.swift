//
//  RequestCardView.swift
//  iOS
//
//  Created by Alexander Hahn on 05.05.25.
//

import SwiftUI

struct RequestCardView: View {
    @State var assignment: Assignment
    @EnvironmentObject var session: SessionManager

    var body: some View {
        let roleViewModel = RoleViewModel(companyId: session.companyId!)
        let employeeViewModel = EmployeeViewModel(companyId: session.companyId!)
        let shiftViewModel = ShiftViewModel(companyId: session.companyId!)
        
        VStack(alignment: .leading, spacing: 8) {
            Text(employeeViewModel.employeeName(for: assignment.employee))
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if shiftViewModel.shifts.indices.contains(assignment.shift) {
                let shift = shiftViewModel.shifts[assignment.shift]
                Text("Start: \(formatDateComponents(shift.startTime)?.date ?? "") um \(formatDateComponents(shift.startTime)?.time ?? "")")                    .font(.headline)
                Text("End: \(formatDateComponents(shift.endTime)?.date ?? "") um \(formatDateComponents(shift.endTime)?.time ?? "")")
                    .font(.headline)
            } else {
                Text("Loading shift data...")
                    .italic()
                    .foregroundColor(.gray)
            }
            

            Text("Role: \(roleViewModel.roleName(for: assignment.role))")
                .font(.headline)
                .bold()

            HStack {
                Button(action: {
                }) {
                    Text("Accept")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                Button(action: {
                }) {
                    Text("Decline")
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 3))
        .padding(.horizontal)
    }

    /*func formatDate(_ date: String) -> String {
        // Convert date string to a readable format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let dateObj = formatter.date(from: date) {
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: dateObj)
        }
        return date
    }
     */
}

#Preview {
    RequestCardView(assignment: Assignment(id: 1, shift: 1, role: 1, employee: 1, confirmed: nil))
}
