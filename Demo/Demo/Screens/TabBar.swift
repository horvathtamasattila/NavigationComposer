import NavigationComposer
import SwiftUI

struct TabBar: View {
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
            }
        )
    }

    var tabBar: some View {
        VStack(spacing: 0) {
            Spacer()
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
                .padding(.bottom, 16)
            }
            .frame(height: 80)
            .background(Color.gray)
            .cornerRadius(16)
            .padding(.bottom, -16)
            Color.gray
                .edgesIgnoringSafeArea(.bottom)
                .frame(height: 20)
                .padding(.bottom, -20)
        }
    }
}

struct TabBarButton: View {
    let label: String
    let image: String
    let action: () -> Void
    var body: some View {
        Button(
            action: { self.action() },
            label: {
                VStack {
                    Image(systemName: image)
                    Text(label)
                        .font(.caption)
                }
            }
        )
    }
}

struct ContentScreen: View {
    let title: String
    let description: String
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .padding(.bottom, 40)
            Text(description)
                .font(.body)
        }

    }
}
