import SwiftUI

struct ChapelView : View {
    @StateObject var viewModel: ViewModel
    var chapelData : String
    var body : some View {
        VStack{
            //Use chapelData as customizing
            Spacer()
            BottomToolbar(viewModel: viewModel)
        }
    }
}
