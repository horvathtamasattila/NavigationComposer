import SwiftUI

public struct NavigationComposer<Content: View, Navigation: View>: View {
    let screenCount: Int
    @Binding var currentIndex: Int
    let animation: Animation?
    let isSwipeable: Bool
    let alignment: Alignment
    let content: Content
    let navigation: Navigation?
    let navigationPosition: NavigationPosition?
    public init(
        screenCount: Int,
        currentIndex: Binding<Int>,
        animation: Animation? = .default,
        isSwipeable: Bool = false,
        alignment: Alignment = .horizontal,
        @ViewBuilder content: () -> Content,
        navigation: (() -> Navigation)? = nil,
        navigationPosition: NavigationPosition? = nil
    ) {
        self.screenCount = screenCount
        self._currentIndex = currentIndex
        self.animation = animation
        self.isSwipeable = isSwipeable
        self.alignment = alignment
        self.content = content()
        self.navigation = navigation?()
        self.navigationPosition = navigationPosition
    }

    public var body: some View {
        GeometryReader { geometry in
            if let navigationPosition = self.navigationPosition {
                switch navigationPosition {
                case .top:
                    VStack {
                        self.navigation
                            .animation(self.animation)
                        Core(
                            geometry: geometry,
                            screenCount: screenCount,
                            currentIndex: $currentIndex,
                            animation: animation,
                            isSwipeable: isSwipeable,
                            alignment: alignment,
                            content: content
                        )
                    }
                case .bottom:
                    VStack {
                        Core(
                            geometry: geometry,
                            screenCount: screenCount,
                            currentIndex: $currentIndex,
                            animation: animation,
                            isSwipeable: isSwipeable,
                            alignment: alignment,
                            content: content
                        )
                        self.navigation
                            .animation(self.animation)
                    }
                }
            } else {
                ZStack {
                    Core(
                        geometry: geometry,
                        screenCount: screenCount,
                        currentIndex: $currentIndex,
                        animation: animation,
                        isSwipeable: isSwipeable,
                        alignment: alignment,
                        content: content
                    )
                    self.navigation
                        .animation(self.animation)
                }
            }
        }
    }

    struct Core: View {
        let geometry: GeometryProxy
        let screenCount: Int
        @Binding var currentIndex: Int
        let animation: Animation?
        let isSwipeable: Bool
        let alignment: Alignment
        let content: Content

        @GestureState private var translation: CGFloat = 0
        private var isHorizontal: Bool {
            self.alignment == .horizontal
        }

        var body: some View {
            Group {
                if self.isHorizontal {
                    HStack(spacing: 0) {
                        self.content.frame(width: geometry.size.width)
                    }
                } else {
                    VStack(spacing: 0) {
                        self.content.frame(height: geometry.size.height)
                    }
                }
            }
            .frame(
                width: self.isHorizontal ? geometry.size.width : nil,
                height: !self.isHorizontal ? geometry.size.height : nil,
                alignment: self.isHorizontal ? .leading : .top
            )
            .offset(
                x: self.isHorizontal ? -CGFloat(self.index()) * geometry.size.width : 0,
                y: !self.isHorizontal ? -CGFloat(self.index()) * geometry.size.height : 0
            )
            .offset(
                x: self.isHorizontal ? self.translation : 0,
                y: !self.isHorizontal ? self.translation : 0
            )
            .animation(self.animation)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    if self.isSwipeable {
                        state = self.isHorizontal ? value.translation.width : value.translation.height
                    }
                }.onEnded { value in
                    if self.isSwipeable {
                        let offset =
                            self.isHorizontal ?
                            value.translation.width / geometry.size.width :
                            value.translation.height * 2 / geometry.size.height
                        let newIndex =
                            self.isHorizontal ?
                            (CGFloat(self.currentIndex) - offset).rounded() :
                            (CGFloat(self.currentIndex) - offset).rounded()
                        withAnimation { self.currentIndex = min(max(Int(newIndex), 0), self.screenCount - 1) }
                    }
                }
            )
        }

        private func index() -> CGFloat {
            if self.currentIndex < 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.currentIndex = 0
                }
                return -0.3
            } else if self.currentIndex >= self.screenCount {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.currentIndex = self.screenCount - 1
                }
                return CGFloat(self.screenCount - 1) + 0.3
            }
            return CGFloat(self.currentIndex)
        }
    }

    public enum Alignment {
        case horizontal
        case vertical
    }

    public enum NavigationPosition {
        case top
        case bottom
    }
}

public extension NavigationComposer where Navigation == EmptyView {
    init(
        screenCount: Int,
        currentIndex: Binding<Int>,
        animation: Animation? = .default,
        isSwipeable: Bool = false,
        alignment: Alignment = .horizontal,
        @ViewBuilder content: () -> Content
    ) {
        self.screenCount = screenCount
        self._currentIndex = currentIndex
        self.animation = animation
        self.isSwipeable = isSwipeable
        self.alignment = alignment
        self.content = content()
        self.navigation = nil
        self.navigationPosition = nil
    }
}
