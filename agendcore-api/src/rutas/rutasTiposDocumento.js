const express = require('express');
const router = express.Router();

const validarToken = require('../middlewares/validar_token');

const {
  listarTiposDocumento
} = require('../controladores/controladorTiposDocumento');

router.get('/', validarToken, listarTiposDocumento);

module.exports = router;