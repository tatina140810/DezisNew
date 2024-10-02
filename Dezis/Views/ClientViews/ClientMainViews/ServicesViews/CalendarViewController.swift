import UIKit

class CalendarViewController: UIViewController {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Календарь"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(method), for: .touchUpInside)
        return button
    }()
   
    let calendar = UICalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Календарь"
        configureClendar()
        setupUI()
    }
    
    private func configureClendar(){
        
        
        calendar.calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ru_RU")
        calendar.visibleDateComponents = DateComponents(calendar: .current, year: 2024, month: 10)
    let dateSelection = UICalendarSelectionMultiDate(delegate: self)
        calendar.selectionBehavior = dateSelection
        calendar.delegate = self
    }
    
    private func setupUI(){
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-14)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        view.addSubview(calendar)
        calendar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
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

    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        .default()
    }
}
