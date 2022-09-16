import SwiftUI

public struct LoginView: View {
    //자동로그인시 사용
    @StateObject private var viewModel : ViewModel = ViewModel(model: Student(id: "", password: ""))
    
    private var id: String
    private var password: String
    
    //TODO : init에서 parameter 없이 viewModel값 입력받는거..?
    //para 있는 경우 : https://stackoverflow.com/questions/64938325/how-to-initialize-a-view-with-a-stateobject-as-a-parameter
    public init() {
        id = ""
        password = ""
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                Text("Usaint viewer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                //text parameter를 통해 사용자가 입력하면 viewModel.id에 값이 바인딩됨
                TextField("ID", text: $viewModel.id)
                    .modifier(FieldStyle())
                    .autocapitalization(.none)
                SecureField("PASSWORD", text: $viewModel.password)
                    .modifier(FieldStyle())
                NavigationLink(destination: HomeView(viewModel: viewModel), isActive: $viewModel.isLogin) {
                    AsyncButton(action: {
                        await viewModel.login(id: viewModel.id, password: viewModel.password)
                    }, label: {
                        HStack {
                            Image(systemName: "lock.open")
                                .padding(EdgeInsets.init(top: 7, leading: 30, bottom: 7, trailing: 0))
                            Text("로그인")
                                .fontWeight(Font.Weight.bold)
                                .font(.system(size: 12))
                                .padding(EdgeInsets.init(top: 7, leading: 0, bottom: 7, trailing: 35))
                        }
                        .foregroundColor(Color.white)
                        .background(Color("loginBackground"))   //Assets 참조
                        .cornerRadius(2)
                        .padding(50)
                        .scaleEffect(x: 2, y: 2)
                        
                    })
                }
                Spacer()
            }
            .padding()
            .padding(.top, 120)
            .ignoresSafeArea()
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(title: Text(""), message: Text("아이디 또는 패스워드가 잘못되었습니다."), dismissButton: .default(Text("닫기")))
            }
        }//NavigationView
    }
}

//refenced by https://pgnt.tistory.com/111
struct FieldStyle: ViewModifier {
    let lightGreyColor = Color(red: 240.0 / 255.0, green: 240.0 / 255.0, blue: 240.0 / 255.0, opacity: 1.0)
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(lightGreyColor)
            .cornerRadius(5.0)
            .padding(.bottom, 5)
            .disableAutocorrection(true)
    }
}
