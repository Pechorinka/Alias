
import Foundation

class GameRound {
    
    unowned var newWordGenerator: ICanGenerateNewGameWord
    
    private(set) var currentWord = ""

    var nextWordHandler: ((String) -> Void)?
    var remainingRoundSecHandler: ((TimeInterval) -> Void)?
    
    /// Продолжительность раунда
    let roundDuration: TimeInterval
    
    /// Команда, которая щас играет свой раунд
    let team: Team

    private var timer: Timer? = nil
    private var elapsedSec: TimeInterval = 0
    private var roundEndHandler: ((_ accuredScores: Int) -> (Void))?
    private var accuredScores = 0
    private var musicManager = MusicModel()

    // MARK: Init
    public init(
        newWordGenerator: ICanGenerateNewGameWord,
        roundDuration: TimeInterval,
        team: Team
    ) {
        self.newWordGenerator = newWordGenerator
        self.roundDuration = roundDuration
        self.team = team
    }

    // MARK: API

    func start(completion: @escaping (_ accuredScores: Int) -> Void) {
        self.roundEndHandler = completion
        self.startGameTimer()
        self.sendNextWord()
    }
    
    /// Не угадал
    func cancelCurrentWord() {
        self.accuredScores -= 1
        self.sendNextWord()
    }
    
    /// Угадал
    func wordGuessed() {
        self.accuredScores += 1
        self.sendNextWord()
    }
    
    func pauseRound() {
        self.invalidateTimer()
        self.musicManager.player?.pause()
    }
    
    func continueRound() {
        self.startGameTimer()
        self.musicManager.player?.play()
    }
}

// MARK: - Private impl
private extension GameRound {

    func sendNextWord() {
        self.currentWord = self.newWordGenerator.getNewWordToGuess()
        self.nextWordHandler?(self.currentWord)
    }

}

// MARK: Timer staff
private extension GameRound {
    
    func startGameTimer() {
        self.timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.timerTick),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func timerTick() {
        self.elapsedSec += 1
        
        let remainingSec = self.roundDuration - self.elapsedSec
        self.remainingRoundSecHandler?(remainingSec)
        
        if remainingSec == 5 {
            self.musicManager.playSound(soundName: "Last 5 sec")
        }
        
        if remainingSec <= 0 {
            self.musicManager.playSound(soundName: "Start Timer")
            self.invalidateTimer()
            self.roundEndHandler?(self.accuredScores)
        }
    }
    
    /// Таймер останавливается
    func invalidateTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
