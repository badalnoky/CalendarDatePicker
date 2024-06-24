import SwiftUI

struct SwipeGesture {
    var leftSwipe: () -> Void
    var rightSwipe: () -> Void
    private let zero: Double = .zero

    init(
        leftSwipe: @escaping () -> Void,
        rightSwipe: @escaping () -> Void
    ) {
        self.leftSwipe = leftSwipe
        self.rightSwipe = rightSwipe
    }
}

extension SwipeGesture: Gesture {
    public var body: some Gesture {
        DragGesture(minimumDistance: .minimumGestureDistance, coordinateSpace: .local)
            .onEnded { value in
                switch value.translation.width {
                case ...zero:  leftSwipe()
                case zero...:  rightSwipe()
                default:  break
                }
            }
    }
}
