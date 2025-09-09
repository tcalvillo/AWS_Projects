# asti.py

# Starting Lineup in 3-5-2 Formation
starting_lineup = {
    "Portiere": ["Silvio Brustolin"],
    "Difensori": ["Kleto Gjura", "Flavio Chianese", "Theo Parrinello"],
    "Centrocampisti": ["Zdravko Manasiev", "Antonio Cardore", "Matteo Toniato", "Noah Mayr", "Daniel Bresciani"],
    "Attaccanti": ["Diego Valenti", "Daniele Favale"]
}

# Reserves
reserves = [
    "Francesco Dosio", "Mattia Guardalben", "Daniele Alfano", "Giacomo Ghiardelli",
    "Simone Ciancio", "Matteo Garcia Magnelli", "Ludovico Ricci", "Davide Garro",
    "Modou Diop", "Giovanni Kean-Dossè", "Marwen Gazoul", "Rida Fakir"
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
