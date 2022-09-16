import UIKit
import Alamofire

public class ViewModel : ObservableObject{
    @Published var id: String = ""
    @Published var password: String = ""
    @Published var isLogin: Bool = false
    @Published var showingAlert: Bool = false
    var statusCode : Int = 0
    var getUrl : String
    var postUrl : String
    var jsonData : String
    
    public init(model: Student) {
        self.id = model.id
        self.password = model.password
        self.getUrl = "http://15.165.194.15:8080/login?id=\(model.id)&pwd=\(model.password)"
        self.postUrl = "https://ptsv2.com/t/aqfop-1662961410/post"
        self.jsonData = ""
    }
    
    //statusCode를 바로 못불러와서 비동기처리
    func login(id: String, password: String) async{
        //사용자가 TextField 값을 바꿔서 입력한 경우
        getUrl = "http://15.165.194.15:8080/login?id=\(id)&pwd=\(password)"
        await getData()
        
        //status가 OK == 200
        if(statusCode == 200){
            isLogin = true
        } else {
            showingAlert = true
        }
    }
    
    func getChapelData() async -> String{
        getUrl = "http://15.165.194.15:8080/chapel?id=\(id)&pwd=\(password)"
        await getData()
        return jsonData
    }
    
    func getTimetableData() async -> String{
        getUrl = "http://15.165.194.15:8080/timetables?id=\(id)&pwd=\(password)"
        await getData()
        return jsonData
    }
    
    //   referenced by https://gonslab.tistory.com/14
    func getData() async{
        //TODO
        let url = getUrl
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type": "application/json", "Accept": "application/json"])
        .validate(statusCode: 200..<300)
        .responseData(completionHandler: { (json) in
            //여기서 가져온 데이터를 자유롭게 활용
            //            print(json)
            if let statuscode = json.response?.statusCode {
                self.statusCode = statuscode
                //TODO : 가져온 json을 String으로 재가공해야함
            }
            else{
                return
            }})
    }

    func postData() {
        let url = postUrl
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        
        // POST 로 보낼 정보
        let params = ["id":"아이디", "pw":"패스워드"] as Dictionary
        
        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print("POST 성공")
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
}
