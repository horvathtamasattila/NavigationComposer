import NavigationComposer
import SwiftUI

struct Pager: View {
    @State var idx = 0
    var body: some View {
        NavigationComposer(
            screenCount: 7,
            currentIndex: $idx,
            animation: .interactiveSpring(),
            isSwipeable: true,
            content: {
                Color.blue
                Color.yellow
                Color.green
                Color.purple
                Color.red
                Color.gray
                Color.orange
            }
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct PagerView_Previews: PreviewProvider {
    static var previews: some View {
        Pager()
    }
}
