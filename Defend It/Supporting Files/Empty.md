            if prevCoordinate.0 - coordinate.0 != 0 {
                if prevCoordinate.0 > coordinate.0 {
                    coordinate.0 -= 1
                    while !meadowManager.isEmpty(coordinate: &coordinate, forBuildingWith: buildingCard.appearance.size) {
                        coordinate.0 -= 1
                    }
                    buildingCard.appearance.buildingNode.position = Converter.toPosition(from: coordinate)
                    return
                } else {
                    coordinate.0 -= 1
                    while !meadowManager.isEmpty(coordinate: &coordinate, forBuildingWith: buildingCard.appearance.size) {
                        coordinate.0 += 1
                    }
                    buildingCard.appearance.buildingNode.position = Converter.toPosition(from: coordinate)
                    return
                }
            }
            if prevCoordinate.1 - coordinate.1 != 0 {
                if prevCoordinate.1 > coordinate.1 {
                    coordinate.1 -= 1
                    while !meadowManager.isEmpty(coordinate: &coordinate, forBuildingWith: buildingCard.appearance.size) {
                        coordinate.1 -= 1
                    }
                    buildingCard.appearance.buildingNode.position = Converter.toPosition(from: coordinate)
                    return
                } else {
                    coordinate.1 -= 1
                    while !meadowManager.isEmpty(coordinate: &coordinate, forBuildingWith: buildingCard.appearance.size) {
                        coordinate.1 += 1
                    }
                    buildingCard.appearance.buildingNode.position = Converter.toPosition(from: coordinate)
                    return
                }
            }
