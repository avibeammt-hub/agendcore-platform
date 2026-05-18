const express = require('express');
const router = express.Router();

const {
  iniciarSesion
} = require('../controladores/controladorAutenticacion');

router.post('/login', iniciarSesion);

module.exports = router;