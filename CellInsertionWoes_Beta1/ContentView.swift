//
//  ContentView.swift
//  CellInsertionWoes_Beta1
//
//  Created by Jason Ji on 6/20/22.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    
    var body: some View {
        Button("Show") {
            show.toggle()
        }
        .sheet(isPresented: $show) {
            SheetView()
        }
    }
}
struct SheetView: View {
    @State var startDate = Date()
    @State var endDate = Date()
    
    @State var startDatePickerShowing = false
    @State var endDatePickerShowing = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Time Period")) {
                    DateCell(title: "Start", date: startDate, formatter: Formatters.dayAndDate)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                startDatePickerShowing.toggle()
                                endDatePickerShowing = false
                            }
                        }
                    
                    if startDatePickerShowing {
                        DatePicker("Start", selection: $startDate.animation(), in: ...endDate, displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                    
                    DateCell(title: "End", date: endDate, formatter: Formatters.dayAndDate)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation {
                                startDatePickerShowing = false
                                endDatePickerShowing.toggle()
                            }
                        }
                    
                    if endDatePickerShowing {
                        DatePicker("End", selection: $endDate.animation(), in: startDate..., displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                    }
                }
            }
        }
    }
}

struct Formatters {
    static var dayAndDate: DateFormatter = {
        let d = DateFormatter()
        d.dateFormat = "EEEE, MMM d, yyyy"
        return d
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DateCell: View {
    let title: String
    let date: Date
    let formatter: DateFormatter
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(date, formatter: formatter)
                .foregroundColor(.accentColor)
        }
        .contentShape(Rectangle())
    }
}
