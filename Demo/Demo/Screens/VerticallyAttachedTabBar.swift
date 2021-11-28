import NavigationComposer
import SwiftUI

struct VerticallyAttachedTabBar: View {
    @State var currentTab: Int = 0
    var body: some View {
        NavigationComposer(
            screenCount: 4,
            currentIndex: $currentTab,
            content: {
                Group {
                    ContentScreen(title: "Tab1", description: "Check out our books")
                    ContentScreen(title: "Tab2", description: "Your profile")
                    ContentScreen(title: "Tab3", description: "Share your favourite book")
                    ContentScreen(title: "Tab4", description: "Buy some cool books")
                }
                .edgesIgnoringSafeArea(.top)
            },
            navigation: {
                self.tabBar
            },
            navigationPosition: .bottom
        )
    }

    var tabBar: some View {
        VStack {
            HStack {
                Group {
                    Spacer()
                    TabBarButton(label: "Books", image: "book", action: { self.currentTab = 0 })
                    Spacer()
                    TabBarButton(label: "Profile", image: "person.circle", action: { self.currentTab = 1 })
                    Spacer()
                    TabBarButton(label: "Share", image: "square.and.arrow.up", action: { self.currentTab = 2 })
                    Spacer()
                    TabBarButton(label: "Buy", image: "cart", action: { self.currentTab = 3 })
                    Spacer()
                }
                .foregroundColor(.black)
            }
            .frame(height: 64)
            .background(Color.gray)
        }
    }
}

struct FixedTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VerticallyAttachedTabBar()
    }
}
