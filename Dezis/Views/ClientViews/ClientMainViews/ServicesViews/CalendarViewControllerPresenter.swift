import Foundation
import Moya

protocol ICalendarPresenter: AnyObject {
    func bookingRequest() -> BookingInfo?
    func booking(bookingInfo: BookingInfo)
}

class CalendarViewControllerPresenter: ICalendarPresenter {
    
    var bookingInfo: BookingInfo?
    
    var view: ICalendarViewController?
   
    let userNetworkService = UserNetworkService()
    
    init(view: ICalendarViewController) {
        self.view = view
    }
    
    func booking(bookingInfo: BookingInfo) {
//        userNetworkService.booking(service: bookingInfo.service, date: bookingInfo.date, time: bookingInfo.time) { result in
//            switch result {
//                case .success(let success):
//                    print(success)
//                case .failure(let failure):
//                    print(failure)
//            }
//        }
    }
    
    func bookingRequest() -> BookingInfo? {
        return bookingInfo
    }
    
}
