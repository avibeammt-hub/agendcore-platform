const express = require('express');
const router = express.Router();
const { verificarSalud } = require('../controladores/controladorSalud');

router.get('/', verificarSalud);

module.exports = router;