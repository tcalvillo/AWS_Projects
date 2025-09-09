# team.py
from asti import starting_lineup as asti_starting_lineup, reserves as asti_reserves
from biellese import starting_lineup as biellese_starting_lineup, reserves as biellese_reserves

class Team:
    def __init__(self, name):
        self.name = name
        if name == "Asti":
            self.players = {
                'Portiere': asti_starting_lineup['Portiere'],
                'Difensori': asti_starting_lineup['Difensori'],
                'Centrocampisti': asti_starting_lineup['Centrocampisti'],
                'Attaccanti': asti_starting_lineup['Attaccanti'],
                'Reserves': asti_reserves
            }
        elif name == "Biellese":
            self.players = {
                'Portiere': biellese_starting_lineup['Portiere'],
                'Difensori': biellese_starting_lineup['Difensori'],
                'Centrocampisti': biellese_starting_lineup['Centrocampisti'],
                'Attaccanti': biellese_starting_lineup['Attaccanti'],
                'Reserves': biellese_reserves
            }
