import SwiftUI

public extension Int {
    static let weekDayCount: Int = 7
    static let firstMonth: Int = 1
    static let lastMonth: Int = 12
    static let plusOne: Int = 1
    static let minusOne: Int = -1
    static let defaultTimeframe = 50

    var weekDayOffset: Int {
        switch self {
        case 1: return 6
        default: return self - 2
        }
    }
}

public extension Date {
    static var currentYearAsInt: Int {
        Calendar.current.dateComponents(in: .current, from: .now).year!
    }

    static var currentMonthAsInt: Int {
        Calendar.current.dateComponents(in: .current, from: .now).month!
    }

    static var currentYearRange: [Int] {
        Array((Date.currentYearAsInt - .defaultTimeframe)...(currentYearAsInt + .defaultTimeframe))
    }

    var firstOfMonth: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
    }

    var nextMonth: Date {
        Calendar.current.date(byAdding: .month, value: .plusOne, to: self)!
    }

    var previousMonth: Date {
        Calendar.current.date(byAdding: .month, value: .minusOne, to: self)!
    }

    func currentMonth() -> [Date] {
        let range = Calendar.current.range(of: .day, in: .month, for: self)!
        var date = self.firstOfMonth
        var dates: [Date] = []
        for _ in range {
            dates.append(date)
            date = Calendar.current.date(byAdding: .day, value: .plusOne, to: date)!
        }
        return dates
    }

    func monthPreset() -> Int {
        Calendar.current.component(.weekday, from: self.firstOfMonth).weekDayOffset
    }

    func monthPostset() -> Int {
        .weekDayCount - ((self.monthPreset() + self.currentMonth().count) % .weekDayCount)

    }
}

public extension Double {
    static var rightAngle: Double = 90
    static var transitionDuration = 0.5
}

extension CGFloat {
    /// 3 pt
    static var minimumGestureDistance: CGFloat = 3
    /// 8 pt
    static var calendarVerticalPadding: CGFloat = 8
    /// 24 pt
    static var calendarHeaderSpacing: CGFloat = 24
    /// 44 pt
    static var dateSize: CGFloat = 44
    /// 450 pt
    static let defaultCalendarHeight: CGFloat = 450
}

extension String {
    static var empty: String = ""
}

extension Image {
    static let back = Image(systemName: "chevron.left")
    static let next = Image(systemName: "chevron.right")
}

extension View {
    func selectedStyle(isSelected: Bool) -> some View {
        self
            .foregroundStyle(isSelected ? AnyShapeStyle(.background) : AnyShapeStyle(Color.primary))
            .fontWeight(isSelected ? .bold : .regular)
            .background(alignment: .center) {
                Circle().dateSized()
                    .foregroundStyle(isSelected ? AnyShapeStyle(.tint) : AnyShapeStyle(Color.clear))
            }
    }

    func dateSized() -> some View {
        self.frame(width: .dateSize, height: .dateSize)
    }
}

public extension CGFloat {
    /// 4 pt
    static let padding4: CGFloat = 4
    /// 8 pt
    static let padding8: CGFloat = 8
    /// 12 pt
    static let padding12: CGFloat = 12
}
