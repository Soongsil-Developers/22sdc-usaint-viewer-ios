import Foundation
import SwiftUI

public struct HomeView: View {
    @StateObject var viewModel: ViewModel
    
    // Navigation View에서 back 버튼 숨기기 위한 변수
    //    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    public init(viewModel : ViewModel){
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        let version: String = String(format: "%.1f", 1.0)
        let paddingTrailingValue = 20.0
        let paddingLeadingValue = 20.0
        
        var timeTableData : String = ""
        var chapelData : String = ""
        
        VStack {
            HStack {
                //시간표 조회
                NavigationLink(destination: TimetableView(viewModel: viewModel, timeTableData: timeTableData)){
                    AsyncButton(action: {timeTableData = await viewModel.getTimetableData()}, label: {
                        HStack {
                        Image(systemName: "tablecells")
                        Text("시간표 조회")
                    }})
                }
                .padding(.leading, paddingTrailingValue)
                
                //채플 정보 조회
                NavigationLink(destination: ChapelView(viewModel: viewModel, chapelData: chapelData)){
                    AsyncButton(action: { chapelData = await viewModel.getChapelData()},
                                label: {
                        HStack {
                            Image(systemName: "cross")
                            Text("채플 정보 조회")
                        }
                    }
                )
                }
                .padding(.leading, paddingLeadingValue)
            }
            .frame(height: 100, alignment: .center)
            
            //로그아웃
            Button(action: {
                viewModel.showingAlert.toggle()
            }) {
                HStack {
                    Image(systemName: "lock")
                        .padding(EdgeInsets.init(top: 7, leading: 30, bottom: 7, trailing: 0))
                    Text("로그아웃")
                        .fontWeight(Font.Weight.bold)
                        .font(.system(size: 12))
                        .padding(EdgeInsets.init(top: 7, leading: 0, bottom: 7, trailing: 28))
                }
                .foregroundColor(Color("loginBackground"))
                .background(Color.black)   //Assets 참조
                .cornerRadius(2)
                .padding(50)
                .scaleEffect(x: 2, y: 2)
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("로그아웃 하시겠습니까?"), message: nil,
                          primaryButton: .destructive(Text("예"), action: { viewModel.isLogin = false }),
                          secondaryButton: .cancel(Text("아니요")))
                }
            }
            
            //버전 정보 표시
            Text("Usaint-Viewer").bold()
            Text("Version \(version)")
            
        }//Vstack
        .navigationBarTitle(Text("Usaint_Viewer"), displayMode: .inline)
        .padding(.top, -150.0)
        .navigationBarBackButtonHidden(true)
    }//body
}
