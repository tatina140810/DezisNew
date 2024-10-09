import UIKit

class CalendarViewController: UIViewController {
        
        private lazy var datePicker: UIDatePicker = {
            let picker = UIDatePicker()
            picker.preferredDatePickerStyle = .inline
            picker.layer.cornerRadius = 12
            picker.clipsToBounds = true
            picker.backgroundColor = UIColor(hex: "#c8cacb")
            picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
            
            return picker
        }()
        
        private let resetButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Reset", for: .normal)
            button.addTarget(self, action: #selector(resetDate), for: .touchUpInside)
           
            return button
        }()
        
        private let doneButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Done", for: .normal)
            button.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
           
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
            button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
            
            return button
        }()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = UIColor(hex: "#1B2228")
            
            setupUI()
        }
        
        private func setupUI() {
            view.addSubview(datePicker)
            
            datePicker.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(120)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(400)            }
            
          
            datePicker.addSubview(resetButton)
            datePicker.addSubview(doneButton)
            
            resetButton.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(20)
                make.top.equalTo(datePicker.snp.bottom).offset(20)
            }
            
            doneButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-20)
                make.top.equalTo(datePicker.snp.bottom).offset(20)
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
        
        @objc private func dateChanged(_ picker: UIDatePicker) {
            print("Выбранная дата и время: \(picker.date)")
        }
        
        @objc private func resetDate() {
            datePicker.setDate(Date(), animated: true)
        }
        
        @objc private func doneTapped() {
            print("Выбор завершен, дата и время: \(datePicker.date)")
            dismiss(animated: true, completion: nil)
        }
    }
    

