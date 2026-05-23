const express = require('express');
const router = express.Router();

const validarToken = require('../middlewares/validar_token');

const {
  listarEspecialidades,
  crearEspecialidad,
  actualizarEspecialidad,
  eliminarEspecialidad
} = require('../controladores/controladorEspecialidades');

router.get('/', validarToken, listarEspecialidades);
router.post('/', validarToken, crearEspecialidad);
router.put('/:id', validarToken, actualizarEspecialidad);
router.delete('/:id', validarToken, eliminarEspecialidad);

module.exports = router;