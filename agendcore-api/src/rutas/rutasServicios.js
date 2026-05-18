const express = require('express');
const router = express.Router();

const validarToken = require('../middlewares/validar_token');

const {
  listarServicios,
  crearServicio,
  actualizarServicio,
  eliminarServicio
} = require('../controladores/controladorServicios');

router.get('/', validarToken, listarServicios);
router.post('/', validarToken, crearServicio);
router.put('/:id', validarToken, actualizarServicio);
router.delete('/:id', validarToken, eliminarServicio);

module.exports = router;