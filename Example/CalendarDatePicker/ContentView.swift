import SwiftUI
import CalendarDatePicker

struct ContentView: View {
    @State private var selectedDate = Date.now
    var body: some View {
        CalendarDatePicker(selectedDate: $selectedDate) {
            print("Data selection changed.")
        }
    }
}

#Preview {
    ContentView()
}
