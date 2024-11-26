--- create table for heartbeats signal
CREATE TABLE heartbeats (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data TEXT NOT NULL,
    eui TEXT NOT NULL,
    raw JSONB NOT NULL,
    time TIMESTAMP NOT NULL
);
