import NavigationComposer
import SwiftUI

struct Onboarding: View {
    @State var idx = 0
    let onboardingContent = ["Onboarding 1", "Onboarding 2", "Onboarding 3", "Onboarding 4", "Onboarding 5"]
    var body: some View {
        NavigationComposer(
            screenCount: onboardingContent.count,
            currentIndex: $idx,
            content: { self.content },
            navigation: { self.navigation }
        )
        .edgesIgnoringSafeArea(.all)
    }

    var content: some View {
        ForEach(onboardingContent, id: \.self) { title in
            Text(title)
                .font(.largeTitle)
        }
    }

    var navigation: some View {
        VStack(spacing: 0) {
            Spacer()
            Button(
                action: { withAnimation(.interactiveSpring()) { self.idx += 1 } },
                label: {
                    Text("Next")
                        .frame(maxWidth: .infinity, maxHeight: 53)
                        .font(.headline)
                }
            )
            .foregroundColor(.black)
            .background(Color.yellow)
            .cornerRadius(8)
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 15,
                    bottom: 8,
                    trailing: 15
                ))
            Button(
                action: { withAnimation(.interactiveSpring()) { self.idx -= 1 } },
                label: {
                    Text("Back")
                        .frame(maxWidth: .infinity, maxHeight: 53)
                        .font(.headline)
                }
            )
            .foregroundColor(.black)
            .padding(
                EdgeInsets(
                    top: 0,
                    leading: 15,
                    bottom: 56,
                    trailing: 15
                ))
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
