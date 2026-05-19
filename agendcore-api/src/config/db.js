const { Pool } = require('pg');
require('dotenv').config();

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false
  }
});

pool.connect()
  .then(() => {
    console.log('✅ PostgreSQL Neon conectado correctamente');
  })
  .catch((error) => {
    console.error('❌ Error conectando PostgreSQL:', error);
  });

module.exports = pool;