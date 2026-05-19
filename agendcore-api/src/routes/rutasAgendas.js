const express = require('express');
const router = express.Router();

const validarToken = require('../middlewares/validar_token');

const {
  listarAgendas,
  crearAgenda,
  actualizarAgenda,
  eliminarAgenda
} = require('../controladores/controladorAgendas');

router.get('/', validarToken, listarAgendas);
router.post('/', validarToken, crearAgenda);
router.put('/:id', validarToken, actualizarAgenda);
router.delete('/:id', validarToken, eliminarAgenda);

module.exports = router;