//
//  MainViewController.swift
//  NewWords
//
//  Created by 서동운 on 7/20/23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var windowView: UIView!
    @IBOutlet var relatedWordButtons: [UIButton]!
    
    let newWordsDictionary: [String: String] = [
        "중꺽마": "중요한건 꺽이지 않는 마음",
        "오운완": "오늘 운동 완료",
        "그잡채": "그 자체를 재밌게 표현한 말",
        "분좋카": "분위기 좋은 카페",
        "완내스": "완전 내 스타일",
        "킹받네": "열받네, 화나네, king + 열받네",
        "별다줄": "별걸 다 줄인다",
        "알잘딱깔센": "알아서 잘 딱 깔끔하고 센스있게"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapTagWithRelatedWordButtons()
        
        designSearchTextField()
        designWindowView()
        
//        setRandomRelatedWordButtons()
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
        
        let mean = getMeaning(of: sender.text)
        resultLabel.text = wrapResultLabelText(mean)
//        setRandomRelatedWordButtons()
        settingRandomWordButtons()
    }
    
    @IBAction func relatedWordButtonDidTapped(sender: UIButton) {
        searchTextField.text = sender.currentTitle
        let mean = getMeaning(of: sender.currentTitle)
        resultLabel.text = wrapResultLabelText(mean)
//        setRandomRelatedWordButtons()
        settingRandomWordButtons()
    }
    
    func settingRandomWordButtons() {
        let shuffledWords = newWordsDictionary.keys.shuffled()
        for index in 0...relatedWordButtons.count - 1 {
            relatedWordButtons[index].setTitle(shuffledWords[index], for: .normal)
        }
    }
    
//    func getRandomWord(count: UInt = 1) -> [String] {
//        let words = newWordsDictionary.keys
//        var wordContainer = [String]()
//
//        switch count {
//        case 0:
//            let randomWord = words.randomElement()!
//            wordContainer.append(randomWord)
//            return wordContainer
//        case 1...UInt(words.count):
//            var shuffledWords = words.shuffled()
//
//            for _ in 1...count {
//                let word = shuffledWords.popLast()!
//                wordContainer.append(word)
//            }
//            return wordContainer
//        default:
//            return [""]
//        }
//    }
    
    private func mapTagWithRelatedWordButtons() {
        for index in 0...relatedWordButtons.count - 1 {
            relatedWordButtons[index].tag = index
        }
    }
    
//    private func setRandomRelatedWordButtons() {
//        let words = getRandomWord(count: 3)
//        for i in 0...2 {
//            relatedWordButtons[i].setTitle(words[i], for: .normal)
//        }
//    }
    
    private func designSearchTextField() {
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.black.cgColor
    }
    
    private func designWindowView() {
        windowView.layer.cornerRadius = 5
        windowView.layer.shadowColor = UIColor.black.cgColor
        windowView.layer.shadowOffset = CGSize(width: 4, height: 4)
        windowView.layer.shadowRadius = 5
        windowView.layer.shadowOpacity = 0.5
    }
    
    private func getMeaning(of text: String?) -> String? {
        if let text = text, let mean = newWordsDictionary[text] {
            return mean
        } else {
            return nil
        }
    }
    
    private func wrapResultLabelText(_ text: String?) -> String {
        if let text = text {
            return "\(searchTextField.text!)는 \(text)란 의미입니다."
        } else {
            return "검색 결과가 없습니다."
        }
    }
}



