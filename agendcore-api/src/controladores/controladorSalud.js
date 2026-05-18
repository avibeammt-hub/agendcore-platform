const pool = require('../config/db');
const axios = require('axios');

const verificarSalud = async (req, res) => {
  try {
    // 🔹 BD
    const resultadoBD = await pool.query('SELECT NOW()');

    // 🔹 FHIR
    let estadoFHIR = 'OK';
    try {
      await axios.get(`${process.env.FHIR_BASE_URL}/metadata`);
    } catch (error) {
      estadoFHIR = 'ERROR';
    }

    res.json({
      estado: 'OK',
      servidor: 'activo',
      base_datos: 'conectada',
      fhir: estadoFHIR,
      hora_bd: resultadoBD.rows[0].now,
    });

  } catch (error) {
    console.error(error);
    res.status(500).json({
      estado: 'ERROR',
      mensaje: 'Error en la conexión',
    });
  }
};

module.exports = {
  verificarSalud,
};