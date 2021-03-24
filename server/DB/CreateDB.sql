-- CREATE USER esteban WITH PASSWORD 'coosta';
-- GRANT ALL PRIVILEGES ON DATABASE area TO esteban;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO esteban;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO esteban;

CREATE TABLE users(
    user_id serial PRIMARY KEY,
    username VARCHAR (50) UNIQUE NOT NULL,
    password VARCHAR (50) NOT NULL,
    token VARCHAR (260),
    token_fb VARCHAR (260),
);
CREATE TABLE action(
    id serial PRIMARY KEY,
    description VARCHAR (496),
    serviceName VARCHAR (496),
    actionName VARCHAR (496),
);
CREATE TABLE reaction(
    id serial PRIMARY KEY,
    description VARCHAR (496),
    serviceName VARCHAR (496),
    reactionName VARCHAR (496),
);