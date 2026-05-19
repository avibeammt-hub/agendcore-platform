const express = require('express');
const pool = require('../config/db');

const router = express.Router();


const {
  listarIps,
  crearIps,
  actualizarIps,
  eliminarIps
} = require('../controladores/controladorIps');

const validarToken = require('../middlewares/validar_token');

router.get('/', validarToken, listarIps);
router.post('/', validarToken, crearIps);
router.put('/:id', validarToken, actualizarIps);
router.delete('/:id', validarToken, eliminarIps);

router.get('/health', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW() AS fecha_servidor');

    res.json({
      ok: true,
      mensaje: 'Backend ACME Agenda FHIR funcionando correctamente',
      base_datos: 'Conectada',
      fecha_servidor: result.rows[0].fecha_servidor
    });
  } catch (error) {
    res.status(500).json({
      ok: false,
      mensaje: 'Error conectando a la base de datos',
      error: error.message
    });
  }
});

module.exports = router;



