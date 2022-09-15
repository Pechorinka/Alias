
import Foundation

class Teams {
    private var randomTeamNames: [String] = [
        "Хомяки", "Пираты" , "Смайлики", "Булавки", "Кнопочки", "Улет", "Динамит", "Звезды", "Котики", "Космонавты", "Ехидны", "Сухари", "Оладушки", "Звери", "Ребята", "Выдры", "Орлы", "Сырники", "Пельмешки", "Крутые"
    ]
    
    var teamNames: [String] = []
    
    func makeTeams(count: Int) -> [Team] {
        guard count < self.randomTeamNames.count else { return [] }
        let shuffledNames = self.randomTeamNames.shuffled()
        
        teamNames = Array(shuffledNames[..<count])
        
        self.randomTeamNames.removeAll { teamNames.contains($0) }
        
        return teamNames.map { Team(name: $0, scores: 0) }
    }
    
    func makeNewTeam() -> Team {
        guard !self.randomTeamNames.isEmpty else { return Team(name: "Команда мечты") }
        
        let teamName = self.randomTeamNames.randomElement()!
        self.randomTeamNames.removeAll { $0 == teamName }
        
        teamNames.append(teamName)
        
        print (teamNames)
        return Team(name: teamName, scores: 0)
    }
    
    func makeNewTeamName(oldName: String, newName: String) -> Team {
        if teamNames.contains(newName) || newName == "" {
            let team = Team(name: oldName, scores: 0)
            return team
        } else {
            let team = Team(name: newName, scores: 0)
            return team
        }
    }
    
    func eraseDeletedName(oldName: String) {
        teamNames = teamNames.filter() {$0 != oldName}
    }
    
}

