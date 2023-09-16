//
// Created By: Mobile Apps Academy
// Subscribe : https://www.youtube.com/@MobileAppsAcademy?sub_confirmation=1
// Medium Blob : https://medium.com/@mobileappsacademy
// LinkedIn : https://www.linkedin.com/company/mobile-apps-academy
// Twitter : https://twitter.com/MobileAppsAcdmy
//

import SwiftUI

let hashtags = ["#trending", "#viral", "#instagram", "#love", "#explorepage", "#explore", "#instagood", "#fashion", "#follow", "#tiktok", "#like", "#likeforlikes", "#followforfollowback", "#photography", "#india", "#trend", "#instadaily", "#memes", "#music", "#style", "#trendingnow", "#reels", "#foryou", "#likes", "#photooftheday", "#model", "#beautiful", "#bollywood", "#bhfyp", "#insta", "adfadf", "#swiftui", "#iosdeveloper", "#swift", "#ios", "#developer", "#xcode", "#programming", "#coding", "#iosdev", "#iosdevelopment", "#programmer", "#coder", "#swiftlang", "#developerlife", "#softwaredeveloper", "#apple", "#swiftdeveloper", "#appdeveloper", "#appdevelopment", "#swiftdev", "#code", "#developers", "#programmers", "#devlife", "#daysofcode", "#dev", "#codinglife", "#ui", "#mobiledevelopment", "#tech"
]

struct HashtagView: View {
    
    var tags: [String]
    var viewBackground: Color = Color.white
    var cloudBackground: Color = Color.gray
    var font: Font = Font.body
    var action: (String) -> ()
    
    @State private var viewHeight = CGFloat.zero
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { geometry in
                    ScrollView(.vertical) {
                        self.generateHashtagViews(g: geometry)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(viewBackground)
    }
    
    private func generateHashtagViews(g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                self.HashtagTextView(text: tag)
                    .padding([.leading, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if(abs(width - d.width) > g.size.width){
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if tag == self.tags.last! {
                            height = 0
                        }
                        return result
                    })
            }
        }.background(getViewHeight($viewHeight))
        
    }
    
    @ViewBuilder
    private func HashtagTextView(text: String) -> some View {
        Button {
            action(text)
        } label: {
            HStack(alignment: .top) {
                Text(text)
                    .font(font)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(cloudBackground)
            .cornerRadius(30)
        }
    }
    
    private func getViewHeight(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geo -> Color in
            let rect = geo.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}
