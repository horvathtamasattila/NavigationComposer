import NavigationComposer
import SwiftUI

struct VerticalPager: View {
    @State var idx = 0
    var body: some View {
        NavigationComposer(
            screenCount: 7,
            currentIndex: $idx,
            isSwipeable: true,
            alignment: .vertical,
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

struct PagerVertical_Previews: PreviewProvider {
    static var previews: some View {
        VerticalPager()
    }
}
