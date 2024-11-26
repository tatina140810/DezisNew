import UIKit

class PrivacyPage: UIViewController {
    
    private let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .clear
        view.textColor = .white
        view.font = UIFont(name: "SFProText-Bold", size: 14)
        view.isEditable = false
        view.isScrollEnabled = true
        view.text = """
        Общество с ограниченной ответственностью «Дезис Групп»
        ООО «Дезис Групп»
        Адрес: Кыргызская Республика, г. Бишкек, ул, Айни 215
        Тел.: +996999033330 mail: deziskg@gmail.com inst.: @dezis_kg
        ОКПО: 31144477, ИНН: 02004202110176
        Условия использования мобильным приложением
        Настоящие Условия использования (далее — "Условия") регулируют использование мобильного приложения “Dezis Group” (далее — "Приложение"), а также предоставление персональных данных пользователями. Пожалуйста, внимательно ознакомьтесь с данным документом перед регистрацией и использованием нашего Приложения. Регистрация в Приложении и использование его услуг означают, что вы согласны с настоящими Условиями.
        Общие положения 1.1. Приложение “Dezis Group” предоставляет пользователям доступ к различным услугам и информации (далее — "Услуги"). 1.2. Важно, чтобы вы внимательно прочитали эти Условия перед использованием Приложения. 1.3. Используя приложение, вы подтверждаете, что согласны с настоящими Условиями и обязуетесь соблюдать их.
        Регистрация и учетная запись 2.1. Для использования некоторых Услуг в Приложении вам может понадобиться пройти процедуру регистрации, указав личные данные (имя, адрес электронной почты, номер телефона, адрес проживания и другие данные). 2.2. Вы обязуетесь предоставлять достоверную информацию при регистрации и поддерживать актуальность данных. 2.3. Вы несете ответственность за сохранность данных своей учетной записи и обязаны немедленно уведомить нас о любом несанкционированном доступе к вашему аккаунту.
        Использование персональных данных 3.1. Мы обрабатываем ваши персональные данные в соответствии с Политикой конфиденциальности, которая является неотъемлемой частью настоящих Условий. 3.2. Мы гарантируем, что ваши данные будут защищены и не будут переданы третьим лицам без вашего согласия, за исключением случаев, предусмотренных законом. 3.3. Вы даете свое согласие на обработку ваших персональных данных, включая сбор, хранение и использование данных для предоставления услуг, улучшения качества работы Приложения, а также для выполнения других обязательств, предусмотренных этими Условиями.
        Права и обязанности сторон 4.1. Мы обязуемся предоставить вам доступ к Услугам Приложения в рамках возможностей, доступных на момент использования. 4.2. Вы обязуетесь не использовать Приложение для совершения противоправных действий, а также не нарушать права третьих лиц. 4.3. Мы оставляем за собой право в любое время изменять, приостанавливать или прекращать работу Приложения, а также изменять Услуги или условия их предоставления.
        Ограничение ответственности 5.1. Мы не несем ответственности за любые убытки, которые могут возникнуть у вас или третьих лиц в связи с использованием или невозможностью использования Приложения. 5.2. Мы не несем ответственности за действия третьих лиц, включая вредоносные программы, вирусы и другие угрозы, которые могут быть доставлены через Интернет.
        Конфиденциальность и защита данных 6.1. Мы обеспечиваем безопасность персональных данных с помощью современных технологий и принимаем меры для защиты данных от утрат, неправомерного использования или изменений. 6.2. Для получения более подробной информации ознакомьтесь с нашей Политикой конфиденциальности, которая доступна в Приложении.
        Изменения в Условиях 7.1. Мы имеем право в любое время изменять данные Условия. Изменения вступают в силу с момента их публикации в Приложении. 7.2. Вы обязуетесь регулярно проверять данный документ на наличие изменений.
        Заключительные положения 8.1. Настоящие Условия регулируются законодательством Кыргызской Республики. 8.2. Все споры, которые могут возникнуть в связи с использованием Приложения, будут решаться в соответствии с действующим законодательством.
        Контактная информация имеется в шапке документа, для связи в случае возникновения проблем.
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
