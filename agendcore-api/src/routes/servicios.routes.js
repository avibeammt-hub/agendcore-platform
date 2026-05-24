const express = require('express');
const router = express.Router();

const { validarJWT } = require('../middlewares/authMiddleware');

const {
  listarServicios,
  crearServicio,
  actualizarServicio,
  eliminarServicio
} = require('../controllers/servicios.controller');

router.get('/', validarJWT, listarServicios);
router.post('/', validarJWT, crearServicio);
router.put('/:id', validarJWT, actualizarServicio);
router.delete('/:id', validarJWT, eliminarServicio);

module.exports = router;