//
//  EnemyCreationManager.swift
//  Defend It
//
//  Created by Роман Сенкевич on 10.08.22.
//

import SceneKit

class EnemyCreationManager {
    
    /// This class is created to fill this array of waves
    private var waves: [EnemyWaveInput] = []
    
    /// This function adds an enemyWave to the end of the array
    func addWave(startFrame: Int) {
        let wave = EnemyWave(startFrame: startFrame)
        waves.append(wave)
    }
    
    /// A wave consists of oneRaceWaves
    /// This function adds oneRaceWave to the last wave
    func addOneRaceWave(_ race: EnemyRaces, _ level: EnemyLevels, count: Int, interval: Int, startFrame: Int) {
        let enemies = createEnemies(race: race, level: level, count: count)
        let oneRaceWave = OneRaceWave(enemies: enemies, interval: interval, startFrame: startFrame)
        waves.last?.addOneRaceWave(oneRaceWave)
    }
    
    /// This function creates a set of enemies
    private func createEnemies(race: EnemyRaces, level: EnemyLevels, count: Int) -> Set<AnyEnemy> {
        var enemies: Set<AnyEnemy> = []
        for _ in 0..<count {
            let enemy = createEnemy(race, with: level)
            enemies.insert(enemy)
        }
        return enemies
    }
    
    /// 1) This function creates an enemy and adds the necessary SceneNodes to it:
    /// HealthProgressBar and PhysicsBody
    /// 2) This function setup:
    /// enemy start posiiton and enemy path
    /// 3) adds animation
    private func createEnemy(_ race: EnemyRaces, with level: EnemyLevels) -> AnyEnemy {
        let enemy = AbstractFactoryEnemiesImpl.defaultFactory.create(race, with: level)
        /// 1) add nodes
        EnemyPhysicsManager.addPhysicsBody(for: enemy)
        EnemyHealthBarManager.addHealthProgressBar(for: enemy)
        /// 2) setup position and path
        enemy.enemyNode.position = EnemyPathManager.shared.culculateStartPosition()
        enemy.path = EnemyPathManager.shared.calculatePath(for: enemy)
        /// 3) add Animation
        EnemyAnimationManager.addAnimation(for: enemy)
        return enemy
    }
    
    /// This function must be called in order to get the result from all past functions
    func getWaves() -> [EnemyWaveInput] {
        waves
    }
}
