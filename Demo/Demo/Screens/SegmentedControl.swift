import NavigationComposer
import SwiftUI

struct SegmentedControl: View {
    @State var page = 0
    var body: some View {
        ZStack {
            Color.orange
                .edgesIgnoringSafeArea(.all)
            NavigationComposer(
                screenCount: 2,
                currentIndex: self.$page,
                animation: .interactiveSpring(),
                isSwipeable: true,
                content: {
                    Group {
                        Color.blue
                        Color.pink
                    }
                    .edgesIgnoringSafeArea(.all)
                    .padding(.top, 80)
                },
                navigation: {
                    self.segmentedNavigation
                }
            )
        }
    }

    var segmentedNavigation: some View {
        GeometryReader { geometry in
            VStack {
                HStack(spacing: 0) {
                    Text("Page 1")
                        .frame(width: geometry.size.width / 2, height: 37)
                        .font(.body)
                        .foregroundColor(
                            self.page == 0 ?
                                Color.yellow :
                                Color.gray
                        )
                        .background(
                            self.page == 0 ?
                                Color.black :
                                Color.white
                        )
                        .cornerRadius(8)
                        .onTapGesture {
                            withAnimation { self.page = 0 }
                        }
                    Text("Page 2")
                        .frame(width: geometry.size.width / 2, height: 37)
                        .font(.body)
                        .foregroundColor(
                            self.page == 1 ?
                                Color.yellow :
                                Color.gray
                        )
                        .background(
                            self.page == 1 ?
                                Color.black :
                                Color.white
                        )
                        .cornerRadius(8)
                        .onTapGesture {
                            withAnimation { self.page = 1 }
                        }
                }
                .frame(width: geometry.size.width - 2 * 16, height: 37)
                .background(Color.white)
                .cornerRadius(8)
                .padding(.top, 8)
                .padding(.horizontal, 16)
                Spacer()
            }
        }
    }
}

struct SegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControl()
    }
}
