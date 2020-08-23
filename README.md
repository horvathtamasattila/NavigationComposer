# NavigationComposer
This package offers an alternative solution to some basic navigation types, which can be problematic to use or hard to customize if you are trying to use the stock solutions.

### Pull requests and suggestions welcome :)


## Table of Contents
* [Getting Started](#getting-started)
* [Usage](#usage)
    * [How it works](#how-it-works)
    * [Parameters](#parameters)
    * [Examples](#usage)
* [License](#license)


## Getting Started
NavigationComposer is a Swift package. You can add it to your project via Xcode's File -> Swift Packages -> Add package dependency option. The URL is https://github.com/horvathtamasattila/NavigationComposer.

## How it works
The main idea is that all screens you are using are rendered and present at the same time, and with setting `currentIndex` you are basically moving them horizontally or vertically. Please keep in mind that because of this behaviour `onAppear` will not work as you might expect, it will only be triggered when `NavigationComposer` loads, and won't be triggered when you navigate to a specific screen within `content`.

## Parameters
* screenCount: The number of screens you are using.
* currentIndex: This binding tells the library which screen to show, and it is also modified in case of swiping. You don't have to worry about this value being out of bounds of your screen count, as those occasions are handled within the library.
* animation: The type of animation you want to use when changing screens. You can also set this to `nil`. The default value is `Animation.default`
* isSwipeable: Determines if you can use a swipe gesture to change views or not.
* aligment: With this you can set whether you want your screens aligned and animated horizotally or vertically. The default alignment is horizontal.
* content: Here come the screens you want to use. Don't put them into any stack, just list them.
* navigation: Here you can define a UI on top of your content screens which is supposed to handle the navigation(which means manipulating the `currentIndex` bindign), but you can build here any UI you want. This is optional, if you just want to use swipe gesture to navigate or you are manipulating the binding externally, you don't have to use it.

## Usage

### Example - Pager:
This is a simple swipe-based pager, no navigation elements are used. Alternatively, you can use `alignment: .vertical` for vertical swiping.

<img src="/ReadmeAssets/pager.gif" width="300">   <img src="/ReadmeAssets/pager-vertical.gif" width="300">

```swift
import SwiftUI
import NavigationComposer

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
```

### Example - Onboarding:
This is an onboarding-like navigation, controlled by a `next` and a `back` button. Also an example of how to use `NavigationComposer` with dynamic screen content.

<img src="/ReadmeAssets/onboarding.gif" width="300">

```swift
import SwiftUI
import NavigationComposer

struct Onboarding: View {
    @State var idx = 0
    let onboardingContent = ["Onboarding 1", "Onboarding 2", "Onboarding 3", "Onboarding 4", "Onboarding 5"]
    var body: some View {
        NavigationComposer(
            screenCount: onboardingContent.count,
            currentIndex: $idx,
            animation: .interactiveSpring(),
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
                action: { self.idx += 1 },
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
                action: { self.idx -= 1 },
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
```
### Example - TabBar

<img src="/ReadmeAssets/tabbar.gif" width="300">

```swift
import SwiftUI
import NavigationComposer

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

```

### Example - Segmented Control

<img src="/ReadmeAssets/segmented-control.gif" width="300">

```swift
import SwiftUI
import NavigationComposer

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
                .padding(.top, 10)
                Spacer()
            }
        }
    }
}

```

## License
Distributed under the MIT License. See `LICENSE` for more information.
