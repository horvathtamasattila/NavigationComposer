import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationView {
            Form {
                NavigationLink("Onboarding", destination: Onboarding())
                NavigationLink("Pager", destination: Pager())
                NavigationLink("Vertical pager", destination: VerticalPager())
                NavigationLink("Tab bar", destination: TabBar())
                NavigationLink("Vertically attached tab bar", destination: VerticallyAttachedTabBar())
                NavigationLink("Segmented control", destination: SegmentedControl())
            }
            .navigationBarTitle("Use Cases")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
