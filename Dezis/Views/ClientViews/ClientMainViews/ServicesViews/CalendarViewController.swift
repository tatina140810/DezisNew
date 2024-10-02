//
//  CalendarViewController.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 2/10/24.
//

import UIKit

class CalendarViewController: UIViewController {
   
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
    }
    
    private func setupUI(){
        view.addSubview(calendar)
        calendar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
