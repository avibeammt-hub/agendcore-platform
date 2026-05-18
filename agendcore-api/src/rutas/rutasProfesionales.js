const express = require('express');
const router = express.Router();

const validarToken = require('../middlewares/validar_token');

const {
  listarProfesionales,
  crearProfesional,
  actualizarProfesional,
  eliminarProfesional
} = require('../controladores/controladorProfesionales');

router.get('/', validarToken, listarProfesionales);
router.post('/', validarToken, crearProfesional);
router.put('/:id', validarToken, actualizarProfesional);
router.delete('/:id', validarToken, eliminarProfesional);

module.exports = router;