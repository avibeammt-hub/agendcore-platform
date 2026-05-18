const express = require('express');
const router = express.Router();

const validarToken = require('../middlewares/validar_token');

const {
  listarRolesProfesional,
  crearRolProfesional,
  actualizarRolProfesional,
  eliminarRolProfesional
} = require('../controladores/controladorRolesProfesional');

router.get('/', validarToken, listarRolesProfesional);
router.post('/', validarToken, crearRolProfesional);
router.put('/:id', validarToken, actualizarRolProfesional);
router.delete('/:id', validarToken, eliminarRolProfesional);

module.exports = router;