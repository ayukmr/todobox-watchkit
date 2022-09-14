//
//  SectionsList.swift
//  TodoBox WatchKit Extension
//
//  Created by Ayush Kumar on 1/13/22.
//

import SwiftUI

struct SectionsList: View {
    @State var sections: Array<Section>?
    @State var tasks: Array<Task>?
    let token: String

    func loadData() {
        getSections(token) { data in
            if let data = data {
                sections = [
                    Section(id: "@all",   name: "All Tasks", color: "#55b9fa"),
                    Section(id: "@today", name: "Today",     color: "#f55f64"),
                ] + data
            }
        }

        getTasks(token) { data in
            if let data = data {
                tasks = data
            }
        }
    }

    @State var todayMs: Int64?

    func getTodayMs() {
        let formatter = DateFormatter()
        formatter.dateFormat = "d M y"

        let today = formatter.date(from: formatter.string(from: Date()))!
        todayMs = Int64((today.timeIntervalSince1970 * 1000.0).rounded())
    }

    func getTasks(_ section: Section) -> Array<Task> {
        switch section.id {
        case "@all":
            return tasks!
        case "@today":
            return tasks!.filter { ($0.date != nil) && (todayMs != nil) && $0.date! == todayMs! }
        default:
            return tasks!.filter { $0.section == section.id }
        }
    }

    var body: some View {
        VStack {
            if sections != nil && tasks != nil {
                List(sections!) { section in
                    NavigationLink {
                        TasksList(
                            tasks: getTasks(section),
                            sectionName: section.name,
                            sectionId: section.id,
                            loadData: loadData,
                            token: token
                        )
                    } label: {
                        SectionRow(section: section)
                    }
                }.navigationTitle("TodoBox")
            } else {
                ProgressView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            loadData()
            getTodayMs()
        }
    }
}

struct SectionsList_Previews: PreviewProvider {
    static var previews: some View {
        SectionsList(token: "")
    }
}
