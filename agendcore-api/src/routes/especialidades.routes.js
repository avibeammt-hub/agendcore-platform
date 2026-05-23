const express = require('express');
const router = express.Router();

const { validarJWT } = require('../middlewares/authMiddleware');

const {
  listarEspecialidades,
  crearEspecialidad,
  actualizarEspecialidad,
  eliminarEspecialidad
} = require('../controllers/especialidades.controller');

router.get('/', validarJWT, listarEspecialidades);
router.post('/', validarJWT, crearEspecialidad);
router.put('/:id', validarJWT, actualizarEspecialidad);
router.delete('/:id', validarJWT, eliminarEspecialidad);

module.exports = router;