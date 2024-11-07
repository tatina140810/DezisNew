import Foundation
import Moya

protocol ICalendarPresenter: AnyObject {
    func bookingRequest() -> BookingInfo?
    func  booking(bookingInfo: BookingInfo, completion: @escaping (Result<BookingLoginResponse, Error>) -> Void)
    }

class CalendarViewControllerPresenter: ICalendarPresenter {
   

    var bookingInfo: BookingInfo?
    
    var view: ICalendarViewController?
   
    let userNetworkService = UserNetworkService()
    
    init(view: ICalendarViewController) {
        self.view = view
    }
    func bookingRequest() -> BookingInfo? {
        return bookingInfo
    }
    
    func booking(bookingInfo: BookingInfo, completion: @escaping (Result<BookingLoginResponse, Error>) -> Void) {
        userNetworkService.booking(user: bookingInfo.user, service: bookingInfo.service, date: bookingInfo.date, time: bookingInfo.time, isCompleted: true) { result in
            switch result {
            case .success(let response):
                print("Booking successful with response: \(response)")
                completion(.success(response))
                
            case .failure(let error):
                print("Booking failed with error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }

}
