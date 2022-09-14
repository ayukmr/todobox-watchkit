//
//  SectionRow.swift
//  TodoBox WatchKit Extension
//
//  Created by Ayush Kumar on 1/13/22.
//

import SwiftUI

extension Color {
    init(hex: String) {
        // https://stackoverflow.com/a/56874327

        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0

        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
            case 3:
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6:
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8:
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct SectionRow: View {
    let section: Section

    func getSectionIcon() -> String {
        let icons = [
            "bell":      "bell",
            "bug":       "ant",
            "beaker":    "testtube.2",
            "gift":      "gift",
            "home":      "house",
            "lightbulb": "lightbulb",
            "lock":      "lock",
            "megaphone": "megaphone",
            "bag":       "bag",
            "rocket":    "paperplane",
            "lightning": "bolt",
            "wrench":    "wrench"
        ]

        if section.icon != nil {
            return icons[section.icon!]!
        } else {
            switch section.id {
                case "@all":
                    return "tray"

                case "@today":
                    return "pin"

                default:
                    return "star"
            }
        }
    }

    var body: some View {
        HStack {
            Image(systemName: getSectionIcon())
                .foregroundColor(Color(hex: section.color))
            Text(section.name)
        }
    }
}

struct SectionRow_Previews: PreviewProvider {
    static var previews: some View {
        SectionRow(section: GenerateMockSection())
    }
}
