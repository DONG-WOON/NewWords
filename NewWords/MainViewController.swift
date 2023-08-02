//
//  MainViewController.swift
//  NewWords
//
//  Created by 서동운 on 7/20/23.
//

import UIKit

class MainViewController: UIViewController {
    
    enum NewWord: String, CaseIterable {
        case 중꺽마,오운완,그잡채,분좋카,완내스,킹받네,별다줄,알잘딱깔센
        
        var mean: String {
            switch self {
            case .중꺽마: return "중요한건 꺽이지 않는 마음"
            case .오운완: return "오늘 운동 완료"
            case .그잡채: return "그 자체를 재밌게 표현한 말"
            case .분좋카: return "분위기 좋은 카페"
            case .완내스: return "완전 내 스타일"
            case .킹받네: return "열받네, 화나네, king + 열받네"
            case .별다줄: return "별걸 다 줄인다"
            case .알잘딱깔센: return "알아서 잘 딱 깔끔하고 센스있게"
            }
        }
    }
    
    @IBOutlet weak var searchBar: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var windowView: UIView!
    @IBOutlet var relatedWordButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapTagWithRelatedWordButtons()
        
        designSearchBar()
        makeShadowAndCorner(view: windowView)
        makeShadowAndCorner(view: searchBar)
        
        settingRandomWordButtons()
    }
    
    @IBAction func superViewDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func searchButtonDidTapped(_ sender: UIButton) {
        searchTextFieldDidEndOnExit(searchTextField)
    }
    
    @IBAction func searchTextFieldDidEndOnExit(_ sender: UITextField) {
        
        guard let text = sender.text, text.count > 1 else {
            let alert = UIAlertController(title: "주의", message: "한글자 또는 빈칸으로는 입력이 불가능합니다.\n다시 입력해주세요.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(ok)
            alert.addAction(cancel)
            
            present(alert, animated: true)
            return
        }
        
        let mean = NewWord(rawValue: text)?.mean
        resultLabel.text = wrapResultLabelText(mean)
        settingRandomWordButtons()
    }
    
    @IBAction func relatedWordButtonDidTapped(sender: UIButton) {
        searchTextField.text = sender.currentTitle
        let mean = NewWord(rawValue: sender.currentTitle!)?.mean
        resultLabel.text = wrapResultLabelText(mean)
        settingRandomWordButtons()
    }
    
    func settingRandomWordButtons() {
        let shuffledWords = NewWord.allCases.shuffled()
        for index in 0...relatedWordButtons.count - 1 {
            relatedWordButtons[index].setTitle(shuffledWords[index].rawValue, for: .normal)
        }
    }
    
    private func mapTagWithRelatedWordButtons() {
        for index in 0...relatedWordButtons.count - 1 {
            relatedWordButtons[index].tag = index
        }
    }
    
    private func designSearchBar() {
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.black.cgColor
    }
    
    private func makeShadowAndCorner(view: UIView) {
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
    }
    
    private func wrapResultLabelText(_ text: String?) -> String {
        if let text = text {
            return "\(searchTextField.text!)는 \(text)란 의미입니다."
        } else {
            return "검색 결과가 없습니다."
        }
    }
}
