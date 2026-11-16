CREATE TABLE IF NOT EXISTS game_save (
    id INTEGER PRIMARY KEY,
    player_name TEXT NOT NULL DEFAULT 'Player',
    crystals_collected INTEGER NOT NULL DEFAULT 0
        CHECK (crystals_collected BETWEEN 0 AND 8),
    lives INTEGER NOT NULL DEFAULT 3
        CHECK (lives BETWEEN 0 AND 3),
    updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

