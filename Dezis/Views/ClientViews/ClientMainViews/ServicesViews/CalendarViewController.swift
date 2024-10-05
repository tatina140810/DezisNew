import UIKit

class CalendarViewController: UIViewController {
   
    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(method), for: .touchUpInside)
        return button
    }()
   
    let calendar = UICalendarView()
    
    private var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Выберите услугу:"
            label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.textAlignment = .left
            return label
        }()
    private var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Заказать услугу", for: .normal)
        button.backgroundColor = UIColor(hex: "#0A84FF")
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        configureClendar()
        setupUI()
    }
    
    
    private func configureClendar(){
        
        
        calendar.calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ru_RU")
        calendar.visibleDateComponents = DateComponents(calendar: .current, year: 2024, month: 10)
        calendar.backgroundColor = UIColor(hex: "#F9F9F9C7")
        calendar.layer.cornerRadius = 13.3
        calendar.clipsToBounds = true
        calendar.timeZone = .current
   
        let dateSelection = UICalendarSelectionMultiDate(delegate: self)
        calendar.selectionBehavior = dateSelection
        calendar.delegate = self
    }
    
    private func setupUI(){
        
        view.addSubview(calendar)
        calendar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
           
        }
        view.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.height.equalTo(48)
        }
    }
    @objc func orderButtonTapped(){
        let vc = SuccessAlertForOrderButtonViewController()
    
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }


}
extension CalendarViewController: UICalendarViewDelegate, UICalendarSelectionMultiDateDelegate {
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {

        
    }
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectDate dateComponents: DateComponents) -> Bool {
        true
    }
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectSingleDate dateComponents: DateComponents) -> Bool {
        true
    }

//    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
//        .default()
//    }
}
