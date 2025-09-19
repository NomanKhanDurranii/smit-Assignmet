-- 1. Runner Table
CREATE TABLE runner (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    main_distance INT NOT NULL CHECK (main_distance > 0), -- in meters
    age INT CHECK (age > 0),
    is_female BOOLEAN NOT NULL
);

-- 2. Event Table
CREATE TABLE event (
    id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    start_date DATE NOT NULL,
    city VARCHAR(100) NOT NULL
);

-- 3. Runner_Event Table (many-to-many relation)
CREATE TABLE runner_event (
    runner_id INT REFERENCES runner(id) ON DELETE CASCADE,
    event_id INT REFERENCES event(id) ON DELETE CASCADE,
    PRIMARY KEY (runner_id, event_id)
);


-- ###			INSERTION COMMANDS			###


-- RUNNER'S TABLE

INSERT INTO runner (name, main_distance, age, is_female) VALUES
('Ali Khan', 5000, 28, FALSE),
('Sara Malik', 10000, 32, TRUE),
('Hassan Raza', 42195, 40, FALSE), -- Marathoner
('Ayesha Shah', 21097, 25, TRUE), -- Half marathon
('Omar Iqbal', 10000, 35, FALSE);


-- EVENT'S TABLE


INSERT INTO event (name, start_date, city) VALUES
('London Marathon', '2025-04-13', 'London'),
('Warsaw Runs', '2025-05-20', 'Warsaw'),
('New Year Run', '2025-01-01', 'Karachi'),
('Berlin Half Marathon', '2025-03-30', 'Berlin'),
('Lahore 10K', '2025-06-15', 'Lahore');


-- RUNNER-EVENT TABLE

INSERT INTO runner_event (runner_id, event_id) VALUES
(1, 5), -- Ali in Lahore 10K
(2, 2), -- Sara in Warsaw Runs
(2, 4), -- Sara in Berlin Half
(3, 1), -- Hassan in London Marathon
(4, 4), -- Ayesha in Berlin Half
(4, 2), -- Ayesha in Warsaw Runs
(5, 3), -- Omar in New Year Run
(5, 5); -- Omar in Lahore 10K

