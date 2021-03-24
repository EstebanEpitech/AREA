var pg = require('pg');

dbClient = new pg.Pool({
    host: 'db',
    user: 'esteban',
    password: 'coosta',
    database: 'area',
    port: 5432
});