//
//  ContentView.swift
//  SwiftUI_First
//
//  Created by William.Weng on 2021/5/26.
//

import SwiftUI

struct ContentView: View {
    
    @State var emojiCount = 4                                                              // 要加上@State(屬性包裝器)才可以改值 => struct => mutating
    
    let emojis = [
        "🏳️", "🏴", "🏴‍☠️", "🏁", "🚩",
        "🏳️‍🌈", "🏳️‍⚧️", "🇺🇳", "🇹🇹", "🇹🇷",
        "🇹🇨", "🇹🇲", "🇧🇹", "🇨🇫", "🇨🇳",
        "🇩🇰", "🇪🇨", "🇪🇷", "🇵🇬", "🇧🇷",
        "🇧🇧", "🇵🇾", "🇧🇭", "🇧🇸", "🇵🇦",
    ]
    
    var body: some View {
        
        VStack {
            HStack {
                
                ScrollView {                                                                // 超出範圍怎麼辦？ => ScrollView
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {                // LazyVGrid => 一列 => 四個 (80是測出來的)
                        
                        ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                            CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)    // 長相比例：2:3 => 按比例填滿
                        }
                    }
                        
                }.foregroundColor(.red)
            }
            
            Spacer()                                                                        // 中間的空白
            
            HStack {
                removeButton                                                                // 移除用的Button
                Spacer()
                addButton                                                                   // 新增用的Button
            }
            .padding(.horizontal)
            .font(.largeTitle)
        }
    }
    
    /// 移除用的Button
    var removeButton: some View {
        
        /// 第一個的action:可以不寫 => label:
        Button {
            if (emojiCount > 1) { emojiCount -= 1 }                                         // 最少有一個
        } label: {
            VStack {
                Image(systemName: "minus.circle")                                           // SF Symbols 2 => 上面圖示的名字
            }
        }
    }
    
    /// 新增用的Button
    var addButton: some View {
            
        Button(action: {
            if (emojiCount < emojis.count) { emojiCount += 1 }                              // 最多就是emojis的量
        }, label: {
            VStack {
                Image(systemName: "plus.circle")                                            // SF Symbols 2 => 上面圖示的名字
            }
        })
    }
}

// MARK: - CardView
struct CardView: View {
    
    var content: String                     // 加上一個String變數，讓Text動態能換文字
    
    @State private var isFaceUp = true      // 要加上@State(屬性包裝器)才可以改值 => struct => mutating
    
    var body: some View {
        
        let rectangle = RoundedRectangle(cornerRadius: 20.0)
        let text = Text(content)
        
        ZStack {
            
            /// 正面 => 顯示文字 / 背面 => 沒有文字
            if (!isFaceUp) {
                rectangle.fill()
            } else {
                rectangle.fill().foregroundColor(.white)
                rectangle.strokeBorder(lineWidth: 3.0, antialiased: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                text.font(.largeTitle)
            }

        }.onTapGesture {                    // 點擊後 => isFaceUp = false
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light).previewDevice("iPhone 11")
    }
}
