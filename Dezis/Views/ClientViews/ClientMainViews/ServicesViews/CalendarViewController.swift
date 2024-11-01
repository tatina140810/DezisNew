import UIKit
import Moya

struct BookingInfo {
    var user: Int
    var service: String
    var date: String
    var time: String
}
final class BookingBuilder {
    class func build(bookingInfo: BookingInfo) -> UIViewController {
        let view = CalendarViewController()
        let presenter = CalendarViewControllerPresenter(view: view)
        view.presenter = presenter
        presenter.view = view
        presenter.bookingInfo = bookingInfo
        return view
    }
}

protocol ICalendarViewController {
    
}

class CalendarViewController: UIViewController, ICalendarViewController {
   
    var presenter: ICalendarPresenter?
    
    private var date: String = ""
    private var time: String = ""
    private var service: String = ""

    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.layer.cornerRadius = 12
        picker.clipsToBounds = true
        picker.backgroundColor = UIColor(hex: "#c8cacb")
        picker.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        return picker
    }()
   
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.backgroundColor =  UIColor(hex: "#c8cacb")
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.clipsToBounds = true
        return view
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        return button
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Done", for: .normal)
        return button
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите услугу:"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 18)
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
        return button
    }()
    private var dezinfectionLabel: UILabel = {
        let label = UILabel()
       label.text = "Дезинфекция"
        label.font =  UIFont(name: "SFProDisplay-Regular", size: 18)
        label.textColor = .white
        return label
    }()
    
    private var dezinsectionLabel: UILabel = {
        let label = UILabel()
       label.text = "Дезинcекция"
        label.font =  UIFont(name: "SFProDisplay-Regular", size: 18)
        label.textColor = .white
        return label
    }()
    private var deratizationLabel: UILabel = {
        let label = UILabel()
       label.text = "Дератизация"
        label.font =  UIFont(name: "SFProDisplay-Regular", size: 18)
        label.textColor = .white
        return label
    }()
    
    private var firstCheckBox = CheckboxButton()
    private var secondCheckBox = CheckboxButton()
    private var thirdCheckBox = CheckboxButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupAddTarget()
        setupUI()
        checkBoxSettings()
    }
    
    private func checkBoxSettings(){
        
        firstCheckBox.backgroundColor = UIColor(hex: "#1B2228")
        secondCheckBox.backgroundColor = UIColor(hex: "#1B2228")
        thirdCheckBox.backgroundColor = UIColor(hex: "#1B2228")
        firstCheckBox.addTarget(self, action: #selector(firstCheckBoxTapped), for: .touchUpInside)
               secondCheckBox.addTarget(self, action: #selector(secondCheckBoxTapped), for: .touchUpInside)
               thirdCheckBox.addTarget(self, action: #selector(thirdCheckBoxTapped), for: .touchUpInside)
           
    }
    private func setupAddTarget(){
        resetButton.addTarget(self, action: #selector(resetDate), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
    }
    
    private func setupUI() {
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.trailing.equalToSuperview().inset(20)
            make.width.equalTo(400)
        }

        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom)
            make.height.equalTo(44)
            make.leading.trailing.equalToSuperview().inset(20)
        }

       stackView.addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(datePicker.snp.bottom).offset(2)
        }
        
       stackView.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(datePicker.snp.bottom).offset(2)
        }
        view.addSubview(orderButton)
        orderButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(14)
            make.trailing.equalToSuperview().offset(-14)
            make.height.equalTo(48)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(resetButton.snp.bottom).offset(20)
        }
        view.addSubview(firstCheckBox)
        firstCheckBox.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(24)
            make.width.equalTo(24)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        view.addSubview(secondCheckBox)
        secondCheckBox.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(24)
            make.top.equalTo(firstCheckBox.snp.bottom).offset(10)
        }
        view.addSubview(thirdCheckBox)
        thirdCheckBox.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(24)
            make.top.equalTo(secondCheckBox.snp.bottom).offset(10)
        }
        view.addSubview(dezinfectionLabel)
        dezinfectionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(11)
            make.leading.equalTo(firstCheckBox.snp.trailing).offset(10)
        }
        view.addSubview(dezinsectionLabel)
        dezinsectionLabel.snp.makeConstraints { make in
            make.top.equalTo(dezinfectionLabel.snp.bottom).offset(12)
            make.leading.equalTo(secondCheckBox.snp.trailing).offset(10)
        }
        view.addSubview(deratizationLabel)
        deratizationLabel.snp.makeConstraints { make in
            make.top.equalTo(dezinsectionLabel.snp.bottom).offset(12)
            make.leading.equalTo(thirdCheckBox.snp.trailing).offset(10)
        }
    }
    
    @objc func orderButtonTapped() {
        var bookingInfo = presenter?.bookingRequest()
       
        bookingInfo?.service = service
        bookingInfo?.date = date
        bookingInfo?.time = time
        
        if let bookingInfo = bookingInfo {
       
            presenter?.booking(bookingInfo: bookingInfo) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        let vc = ViewControllerForAlert()
                        self?.navigationController?.pushViewController(vc, animated: true)
                    case .failure(let error):
                       
                        print("Booking failed with error: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            print("Failed to create booking info.")
        }
    }

    @objc private func dateChanged(_ picker: UIDatePicker) {
            let currentDate = picker.date
           
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            date = dateFormatter.string(from: currentDate)
          
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm:ss"
            time = timeFormatter.string(from: currentDate)
            
            print("Выбранная дата: \(date)")
            print("Выбранное время: \(time)")
        
    }
    
    @objc private func resetDate() {
        datePicker.setDate(Date(), animated: true)
    }
    
    @objc private func doneTapped() {
        print("Выбор завершен, дата и время: \(date) \(time)")
        let vc = ViewControllerForAlert()
        navigationController?.present(vc, animated: true)

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
            // Убираем отметку с других чекбоксов
            firstCheckBox.isSelected = false
            secondCheckBox.isSelected = false
            thirdCheckBox.isSelected = false
            
            self.service = service
            selectedCheckBox.isSelected = true
            
            print("Выбранная услуга: \(service)")
        }

    
    func bookingRequestSuccessful() {
            print("Бронирование успешно выполнено")
        }
}


