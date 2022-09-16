import SwiftUI
import Foundation
// 하단 툴바
struct BottomToolbar: View {
    @StateObject var viewModel: ViewModel
    var body : some View{
        VStack {
            HStack {
                //Use bottomToolbar as custominzing
                //Below for instance. It doesn't work.
            
                Spacer()
                Button(action: { print("새로 고침") }, label: { Image(systemName: "goforward") })
                Group {
                    Spacer()
                    Divider()
                    Spacer()
                }

                NavigationLink(destination: HomeView(viewModel: viewModel)){
                    Button(action: { print("홈 화면") }, label: { Image(systemName: "house")}
                    )
                }

                Group {
                    Spacer()
                    Divider()
                    Spacer()
                }

                Button(action: { print("앞으로 가기")}, label: { Image(systemName: "chevron.backward") })
                Spacer(minLength: 80)

                Button(action: { print("앞으로 가기") }, label: { Image(systemName: "chevron.forward") })
                Spacer()
            }
            .frame(height: 45)
            Divider()
        }
    }
}
