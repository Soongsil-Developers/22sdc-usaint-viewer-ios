// delegate 연습용 코드. 프로젝트와 전혀 상관없는 코드.

import Foundation

protocol PrepareParty: class {  //interface
    func prepareFood()
    func prepareSong()
}


class PartyDirector{
    weak var delegate : PrepareParty?

    func order(){
        self.delegate?.prepareFood()
        self.delegate?.prepareSong()
    }
}

class FirstPartyWorker: PrepareParty{
    init(director: PartyDirector){
        director.delegate = self
    }

    func prepareFood() {
        print("퍼스트의 푸드")
    }

    func prepareSong() {
        print("퍼스트의 송")
    }
}

let director = PartyDirector()
let first = FirstPartyWorker(director: director)