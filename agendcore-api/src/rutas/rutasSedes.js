const express = require('express');
const router = express.Router();

const {
  crearSede,
  listarSedes,
  actualizarSede,
  eliminarSede
} = require('../controladores/controladorSedes');

const validarToken = require('../middlewares/validar_token');

router.get('/', validarToken, listarSedes);
router.post('/', validarToken, crearSede);
router.put('/:id', validarToken, actualizarSede);
router.delete('/:id', validarToken, eliminarSede);


module.exports = router;