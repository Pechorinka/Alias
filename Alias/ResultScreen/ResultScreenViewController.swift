
import UIKit

class ResultScreenViewController: UIViewController {
    
//    private let alertManager = AlertManager()
    let resultScreenView = ResultScreenView()

    override func loadView() {
        self.view = self.resultScreenView
 //       resultScreenView.delegate = self
        
        resultScreenView.tapImageBtn = {
            [weak self] in
            guard let self = self else { return }
            let vc = JokeViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
       
}

//MARK: - PresentAlertDelegate
////Пуш алерта при нажатии на кубок
//extension ResultScreenViewController: PresentAlertDelegate {
//    func presentAlert() {
//        //let alert =
//        alertManager.showCustomAlert(with: "Привет", message: "Я алерт", on: self)
//        //showAlert(text: "Леша, привет! Ты большой молодец!)")
//           // present(alert, animated: true)
//    }
//
//    @objc func dismissAlert(){
//        alertManager.dismissAlert()
//    }
//}
