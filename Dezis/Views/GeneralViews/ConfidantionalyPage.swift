import UIKit

class ConfidantionalyPage: UIViewController {
    
    private let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.textColor = .white
        view.font = UIFont(name: "SFProText-Bold", size: 14)
        view.isEditable = false
        view.isScrollEnabled = true
        view.text = """
        Общество с ограниченной ответственностью «Дезис Групп»
        ОсОО «Дезис Групп»
        Адрес: Кыргызская Республика, г. Бишкек, ул, Айни 215
        Тел.: +996999033330 mail: deziskg@gmail.com inst.: @dezis_kg
        ОКПО: 31144477, ИНН: 02004202110176
        Политика конфиденциальности
        для компании по дезинсекции «ОсОО Dezis Group»

        Дата вступления в силу: с момента публикации

        Настоящая Политика конфиденциальности определяет порядок сбора, использования, хранения и защиты персональной информации клиентов компании «ОсОО Dezis». Мы стремимся обеспечить защиту ваших данных в соответствии с применимыми законами и стандартами безопасности.

        1. Сбор персональных данных

        Мы можем собирать следующие виды персональных данных:
        1.1. Контактные данные: имя, номер телефона, адрес электронной почты, адрес проживания.
        1.2. Адресные данные: адрес объекта, где требуется оказание услуг.
        1.3. Информация о заказе: вид услуги, дата и время проведения обработки.
        1.4. Технические данные: IP-адрес, данные о браузере, файлы cookie (при использовании нашего Приложения).

        2. Использование персональных данных

        Собранные данные используются для следующих целей:
        2.1. Обеспечение качественного оказания услуг.
        2.2. Подтверждение и обработка заказов.
        2.3. Связь с клиентом для уточнения деталей заказа или предоставления информации.
        2.4. Улучшение качества предоставляемых услуг и анализа клиентских предпочтений.
        2.5. Соблюдение требований законодательства.

        3. Хранение и защита данных

        3.1. Мы принимаем все необходимые организационные и технические меры для защиты ваших данных от несанкционированного доступа, изменения, раскрытия или уничтожения.
        3.2. Срок хранения персональных данных составляет не более 75 лет, если иное не предусмотрено законодательством.

        4. Передача данных третьим лицам

        4.1. Ваши данные могут быть переданы третьим лицам только в следующих случаях:
        • Для выполнения обязательств по договору (например, привлеченные подрядчики).
        • По запросу государственных органов в рамках законодательства.
        4.2. Мы не передаем данные третьим лицам в коммерческих целях без вашего согласия.

        5. Права клиента

        Вы имеете право:
        5.1. Получать информацию о том, какие ваши данные обрабатываются.
        5.2. Требовать исправления, обновления данных.
        5.3. Подать жалобу в уполномоченные органы, если считаете, что ваши права нарушены.
        6. Права компании

        Компания имеется право: 6.1. В одностороннем порядке изменять условия пользования и политику конфиденциальности приложения и сайта
        6.2. В одностороннем порядке удалить аккаунт пользователя при нарушении условий, или несоблюдения правовых норм в Кыргызской Республике.
        6.3. Согласовать время работ также менять их при невозможности исполнить услуги в указанное время клиента.
        6.4. Без предупреждения отключить мобильное приложение и сайт для введения технических работ или полную терминацию.

        7. Использование файлов cookie

        Мы используем файлы cookie для улучшения работы нашего Приложения. 


        Ваше использование услуг нашей компании означает согласие с настоящей Политикой конфиденциальности.
        """
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#1B2228")
        setupUI()
        setupNavigation()
    }
    
    private func setupUI() {
        view.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupNavigation() {
        let backButton = UIButton(type: .system)
        backButton.setTitle("Назад", for: .normal)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.titleLabel?.font = UIFont(name: "SFProText-Regular", size: 17)

        let chevronImage = UIImage(resource: .shevron).withRenderingMode(.alwaysTemplate)
        let resizedChevron = UIGraphicsImageRenderer(size: CGSize(width: 8, height: 14)).image { _ in
            chevronImage.draw(in: CGRect(origin: .zero, size: CGSize(width: 8, height: 14)))
        }
        backButton.setImage(resizedChevron, for: .normal)
        backButton.tintColor = .systemBlue

        backButton.semanticContentAttribute = .forceLeftToRight
        backButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -7, bottom: 0, right: 5)
        backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: -5)

       
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButtonItem
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
