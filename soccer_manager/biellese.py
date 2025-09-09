# biellese.py

# Starting Lineup in 3-5-2 Formation
starting_lineup = {
    "Portiere": ["Matteo Boraso"],
    "Difensori": ["Daniele Brancato", "Vincenzo Chianese", "Aymane El Achkaoui"],
    "Centrocampisti": ["Marco Bernardo", "Stefano Capellupo", "Giuseppe Colletta", "Davide Gila", "Giovanni Graziano"],
    "Attaccanti": ["Edoardo Bruno Artiglia", "Paolo Caramori"]
}

# Reserves
reserves = [
    "Mattia Vergna", "Davide Facchetti", "Nicolò Pavan", "Roberto Raimondo",
    "Vittorio Tomasino", "Abdelaziz Madiq", "Riccardo Secondo",
    "Emanuele Marra", "Davide Mazzoni", "Francesco Messina", "Jabir Naamad", "Soufiane Sekka"
]

# Display the starting lineup and reserves
def display_team():
    print("Starting Lineup (3-5-2):")
    for role, players in starting_lineup.items():
        print(f"{role}: {', '.join(players)}")
    print("\nReserves:")
    print(', '.join(reserves))

if __name__ == "__main__":
    display_team()
