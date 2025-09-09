# match_engine.py
import random

def simulate_match(team1, team2):
    events = []
    team1_players = team1.players
    team2_players = team2.players

    team1_goals = 0
    team2_goals = 0

    # Simulate some goals for both teams
    for _ in range(random.randint(3, 7)):
        if random.choice([True, False]):
            scorer = random.choice(team1_players['Attaccanti'])
            team1_goals += 1
            events.append(f"{len(events)+1}' - GOAL! {team1.name} scores by {scorer}")
        else:
            scorer = random.choice(team2_players['Attaccanti'])
            team2_goals += 1
            events.append(f"{len(events)+1}' - GOAL! {team2.name} scores by {scorer}")

    return f"{team1.name} {team1_goals} - {team2_goals} {team2.name}", events
