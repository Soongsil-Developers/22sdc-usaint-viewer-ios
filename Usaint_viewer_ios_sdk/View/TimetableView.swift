import SwiftUI

struct TimetableView : View {
    @StateObject var viewModel: ViewModel
    var timeTableData : String
    var body : some View {
        VStack{
            //Use timeTableData as customizing
            Spacer()
            BottomToolbar(viewModel: viewModel)
        }
    }
}
