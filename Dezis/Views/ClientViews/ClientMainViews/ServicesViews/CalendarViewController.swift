import UIKit
import Moya

struct BookingInfo {
    var user: Int
    var service: String
    var date: String
    var time: String
    var is_completed: Bool
}

protocol ICalendarViewController {
    
}

class CalendarViewController: UIViewController, ICalendarViewController {
    
    var presenter: ICalendarPresenter?
    
    private var user: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "userId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
    }
    
    private var date: String = ""
    private var time: String = ""
    private var serviceArray: [String] = []
    private var isCompleted: Bool = false
    private var service: String = ""
    
    
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .date
        picker.layer.cornerRadius = 13.33
        picker.clipsToBounds = true
        picker.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        picker.backgroundColor = UIColor(hex: "#C8CACB")
        let loc = Locale(identifier: "ru_RU")
        picker.locale = loc
        picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        return picker
    }()
    private lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.layer.cornerRadius = 13
        timePicker.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        timePicker.clipsToBounds = true
        timePicker.backgroundColor = UIColor(hex: "F9F9F9")
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        timePicker.isHidden = true
        return timePicker
    }()
    private var firstStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .fillProportionally
        view.spacing = 8
        view.backgroundColor =  UIColor(hex: "#C8CACB")
        view.layer.cornerRadius = 13
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.clipsToBounds = true
        view.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16)
        view.isLayoutMarginsRelativeArrangement = true
        
        
        return view
    }()
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.backgroundColor = UIColor(hex: "#F9F9F9")
        view.layer.cornerRadius = 13
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.clipsToBounds = true
        view.isHidden = true
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor(hex: "#007AFF"), for: .normal)
        button.setTitle("Сбросить", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(UIColor(hex: "#007AFF"), for: .normal)
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 17)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите услугу:"
        label.font = UIFont(name: "SFProText-Regular", size: 18)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Заказать услугу", for: .normal)
        button.backgroundColor = UIColor(hex: "#0A84FF")
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 18)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        return button
    }()
    private var dezinfectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Дезинфекция"
        label.font =  UIFont(name: "SFProText-Regular", size: 18)
        label.textColor = .white
        return label
    }()
    
    private var dezinsectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Дезинcекция"
        label.font =  UIFont(name: "SFProText-Regular", size: 18)
        label.textColor = .white
        return label
    }()
    private var deratizationLabel: UILabel = {
        let label = UILabel()
        label.text = "Дератизация"
        label.font =  UIFont(name: "SFProText-Regular", size: 18)
        label.textColor = .white
        return label
    }()
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "Время"
        label.font =  UIFont(name: "SFProText-Bold", size: 17)
        label.textColor = .black
        return label
    }()
    private lazy var timePickerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: "#BFC0C1")
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let currentTime = formatter.string(from: currentDate)
        
        button.setTitle(currentTime, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(timePickerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var firstCheckBox = CheckboxButton()
    private var secondCheckBox = CheckboxButton()
    private var thirdCheckBox = CheckboxButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        checkBoxSettings()
        setupDatePicker()
        presenter = CalendarViewControllerPresenter(view: self)
        overrideUserInterfaceStyle = .light
        navigationController?.navigationBar.isHidden = true
        
    }
    private func checkBoxSettings(){
        
        firstCheckBox.backgroundColor = UIColor(hex: "#1B2228")
        secondCheckBox.backgroundColor = UIColor(hex: "#1B2228")
        thirdCheckBox.backgroundColor = UIColor(hex: "#1B2228")
        firstCheckBox.addTarget(self, action: #selector(firstCheckBoxTapped), for: .touchUpInside)
        secondCheckBox.addTarget(self, action: #selector(secondCheckBoxTapped), for: .touchUpInside)
        thirdCheckBox.addTarget(self, action: #selector(thirdCheckBoxTapped), for: .touchUpInside)
        
    }
    
    private func setupUI() {
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(71)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.3846)
        }
        firstStackView.addArrangedSubview(timeLabel)
        
        firstStackView.addArrangedSubview(timePickerButton)
        timePickerButton.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.width.equalTo(90)
        }
        
        view.addSubview(firstStackView)
        firstStackView.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom)
            make.height.equalTo(44)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        view.addSubview(timePicker)
        timePicker.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(149)
            make.leading.trailing.equalToSuperview().inset(71)
            make.centerX.equalToSuperview()
            make.height.equalTo(188)
        }
        stackView.addArrangedSubview(resetButton)
        stackView.addArrangedSubview(doneButton)
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(timePicker.snp.bottom)
            make.height.equalTo(44)
            make.leading.trailing.equalToSuperview().inset(71)
        }
        
        view.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(firstStackView.snp.bottom).offset(67)
        }
        view.addSubview(firstCheckBox)
        firstCheckBox.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
        }
        view.addSubview(secondCheckBox)
        secondCheckBox.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(24)
            make.top.equalTo(firstCheckBox.snp.bottom).offset(12)
        }
        view.addSubview(thirdCheckBox)
        thirdCheckBox.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(24)
            make.top.equalTo(secondCheckBox.snp.bottom).offset(12)
        }
        view.addSubview(dezinfectionLabel)
        dezinfectionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(firstCheckBox.snp.trailing).offset(10)
        }
        view.addSubview(dezinsectionLabel)
        dezinsectionLabel.snp.makeConstraints { make in
            make.top.equalTo(dezinfectionLabel.snp.bottom).offset(14)
            make.leading.equalTo(secondCheckBox.snp.trailing).offset(10)
        }
        view.addSubview(deratizationLabel)
        deratizationLabel.snp.makeConstraints { make in
            make.top.equalTo(dezinsectionLabel.snp.bottom).offset(14)
            make.leading.equalTo(thirdCheckBox.snp.trailing).offset(10)
        }
    }
    private func setupDatePicker() {
        let calendar = Calendar.current
        let currentDate = Date()
        
        if let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentDate)),
           let endOfMonth = calendar.date(byAdding: .month, value: 2, to: startOfMonth)?.addingTimeInterval(-1) {
            
            datePicker.minimumDate = startOfMonth
            datePicker.maximumDate = endOfMonth
        }
    }
    
    
    @objc private func timeChanged() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        time = formatter.string(from: timePicker.date)
    }
    
    @objc func orderButtonTapped() {
        guard let userId = user, userId != 0 else {
            print("Error: User ID not found in UserDefaults.")
            return
        }
        
        guard !service.isEmpty, !date.isEmpty, !time.isEmpty else {
            print("Error: Missing booking information.")
            return
        }
        
        let bookingInfo = BookingInfo(
            user: userId,
            service: service,
            date: date,
            time: time,
            is_completed: false
        )
        
        print("Создание информации о бронировании:", bookingInfo)
        guard let presenter = presenter else {
            print("Error: Presenter is not initialized.")
            return
        }
        
        presenter.booking(bookingInfo: bookingInfo) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print("Бронирование завершено с ответом:", response)
                    self?.showBookingSuccessAlert(response: response)
                    
                case .failure(let error):
                    print("Ошибка бронирования:", error.localizedDescription)
                    self?.showBookingErrorAlert(error: error)
                }
            }
        }
    }

    private func showBookingSuccessAlert(response: BookingLoginResponse) {
        let vc = ViewControllerForAlert()
        navigationController?.present(vc, animated: true)
    }
    
    private func showBookingErrorAlert(error: Error) {
        let alert = UIAlertController(title: "Ошибка бронирования", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func dateChanged(_ picker: UIDatePicker) {
        let currentDate = picker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        date = dateFormatter.string(from: currentDate)
        print("Выбрана дата: \(date)")
    }
    @objc private func timePickerButtonTapped() {
        showTimePicker()
    }
    private func showTimePicker() {
        timePicker.isHidden = false
        stackView.isHidden = false
    }
    
    @objc private func doneButtonTapped() {
        time = getFormattedTime(timePicker.date)
        print("Выбор завершен, дата и время: \(time)")
        timePickerButton.setTitle(time, for: .normal)
        timePicker.isHidden = true
        stackView.isHidden = true
    }
    
    
    @objc private func resetButtonTapped() {
        timePicker.isHidden = true
        stackView.isHidden = true
        datePicker.setDate(Date(), animated: true)
    }
    
    private func getFormattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "Asia/Bishkek")
        return formatter.string(from: date)
    }
    @objc func firstCheckBoxTapped() {
        selectService(service: "Дезинфекция", selectedCheckBox: firstCheckBox)
    }
    
    @objc func secondCheckBoxTapped() {
        selectService(service: "Дезинcекция", selectedCheckBox: secondCheckBox)
    }
    
    @objc func thirdCheckBoxTapped() {
        selectService(service: "Дератизация", selectedCheckBox: thirdCheckBox)
    }
    
    private func selectService(service: String, selectedCheckBox: CheckboxButton) {
        selectedCheckBox.isSelected.toggle()
        
        if selectedCheckBox.isSelected {
            self.serviceArray.append(service)
        } else {
            if let index = self.serviceArray.firstIndex(of: service) {
                self.serviceArray.remove(at: index)
            }
        }
        
        self.service = self.serviceArray.joined(separator: ", ")
        print("Выбранные услуги: \(self.service)")
    }
    
    
    func bookingRequestSuccessful() {
        print("Бронирование успешно выполнено")
    }
    
    
}


