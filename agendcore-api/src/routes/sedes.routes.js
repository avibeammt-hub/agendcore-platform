const express = require('express');
const router = express.Router();

const {
  crearSede,
  listarSedes,
  actualizarSede,
  eliminarSede
} = require('../controllers/sedes.controller');

const { validarJWT } = require('../middlewares/authMiddleware');

router.get('/', validarJWT, listarSedes);
router.post('/', validarJWT, crearSede);
router.put('/:id', validarJWT, actualizarSede);
router.delete('/:id', validarJWT, eliminarSede);

module.exports = router;