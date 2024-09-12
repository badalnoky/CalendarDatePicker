#if os(macOS)
import SwiftUI

public struct MacCalendarDatePicker {
    var selectedDate: Binding<Date>
    var onDateTapAction: () -> Void

    @State private var selectedMonth: Date = .now
    @State private var transitionEdge: Edge = .trailing
    @State private var isPickerActive = false
    @State private var pickerYear: Int = Date.currentYearAsInt
    @State private var pickerMonth: Int = Date.currentMonthAsInt

    private let firstMonth: Int = .firstMonth
    private let lastMonth: Int = .lastMonth

    public init(
        selectedDate: Binding<Date>,
        onDateTapAction: @escaping () -> Void
    ) {
        self.selectedDate = selectedDate
        self.onDateTapAction = onDateTapAction
    }

    private func increaseSelectedMonth() {
        transitionEdge = .trailing
        withAnimation(.easeInOut(duration: .transitionDuration)) {
            selectedMonth = selectedMonth.nextMonth
            if pickerMonth == .lastMonth {
                pickerMonth = .firstMonth
                pickerYear += .plusOne
            } else {
                pickerMonth += .plusOne
            }
        }
    }

    private func decreaseSelectedMonth() {
        transitionEdge = .leading
        withAnimation(.easeInOut(duration: .transitionDuration)) {
            selectedMonth = selectedMonth.previousMonth
            if pickerMonth == .firstMonth {
                pickerMonth = .lastMonth
                pickerYear -= .plusOne
            } else {
                pickerMonth -= .plusOne
            }
        }
    }

    private func changeSelectedMonth() {
        withAnimation(.easeInOut(duration: .transitionDuration)) {
            var components = DateComponents()
            components.year = pickerYear
            components.month = pickerMonth
            selectedMonth = Calendar.current.date(from: components)!
        }
    }

    private func isSelected(_ date: Date) -> Bool {
        Calendar.current.isDate(selectedDate.wrappedValue, inSameDayAs: date)
    }

    private func selectDate(_ date: Date) {
        selectedDate.wrappedValue = date
    }
}

extension MacCalendarDatePicker: View {
    public var body: some View {
        VStack {
            headerView
            .frame(maxWidth: .infinity)
            .padding(.vertical, .padding8)
            .padding(.horizontal, .padding12)

            Group {
                weekDayView
                monthView
            }
            Spacer()
        }
        .frame(minWidth: .minCalendarWidth, minHeight: .minCalendarHeight)
    }
}

extension MacCalendarDatePicker {
    private var headerView: some View {
        HStack(alignment: .center, spacing: .calendarHeaderSpacing) {
            pickerButton
                .popover(isPresented: $isPickerActive) {
                    dateWheelView
                }
            Spacer()
            Button(action: decreaseSelectedMonth) {
                Image.back
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            Button(action: increaseSelectedMonth) {
                Image.next
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
    }

    private var pickerButton: some View {
        Button(action: { withAnimation { isPickerActive.toggle() }}) {
            Text(selectedMonth, format: .dateTime.month(.wide))
                .font(.headline)
                .foregroundStyle(Color.primary)
            Text(selectedMonth, format: .dateTime.year())
                .font(.headline)
                .foregroundStyle(Color.primary)
            Image.next
                .font(.footnote)
                .bold()
                .rotationEffect(.degrees(isPickerActive ? .rightAngle : .zero))
        }
    }

    private var weekDayView: some View {
        HStack {
            ForEach(Weekday.allCases) { day in
                Text(day.abbreviated.uppercased()).font(.caption).bold()
                    .foregroundStyle(Color.gray)
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, .padding12)
    }

    private var monthView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: .weekDayCount)) {
            Group {
                ForEach(Int.zero..<selectedMonth.monthPreset(), id: \.self) { _ in
                    Color.clear
                }
                ForEach(selectedMonth.currentMonth(), id: \.self) { date in
                    Text(date, format: .dateTime.day())
                        .font(.title3)
                        .padding(.vertical, .padding4)
                        .tag(date)
                        .frame(width: .macDateSize, height: .macDateSize)
                        .macSelectedStyle(isSelected: isSelected(date))
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectDate(date)
                            onDateTapAction()
                        }
                }
                ForEach(.defaultIdOffset..<(selectedMonth.monthPostset().withOffset), id: \.self) { _ in
                    Color.clear
                }
            }
            .transition(.move(edge: transitionEdge).combined(with: .opacity))
        }
        .padding(.horizontal, .padding12)
    }

    private var dateWheelView: some View {
        HStack {
            Picker(String.empty, selection: $pickerMonth) {
                ForEach(firstMonth...lastMonth, id: \.self) {
                    Text(Calendar.current.monthSymbols[$0 - .plusOne])
                }
            }
            .frame(minWidth: .minPickerWidth)
            .onChange(of: pickerMonth) {
                changeSelectedMonth()
            }
            TextField(String.empty, value: $pickerYear, format: .number)
            .onChange(of: pickerYear) {
                changeSelectedMonth()
            }
        }
        .padding()
    }
}

#Preview {
    @State var date = Date.now
    return VStack {
        MacCalendarDatePicker(selectedDate: $date) {}
        Spacer()
    }
}
#endif
