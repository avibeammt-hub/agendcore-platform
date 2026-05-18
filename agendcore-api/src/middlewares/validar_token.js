const jwt = require('jsonwebtoken');

const validarToken = (req, res, next) => {
  try {
    const authorization = req.headers.authorization;

    if (!authorization) {
      return res.status(401).json({
        estado: 'ERROR',
        mensaje: 'Token no enviado'
      });
    }

    const partes = authorization.split(' ');

    if (partes.length !== 2 || partes[0] !== 'Bearer') {
      return res.status(401).json({
        estado: 'ERROR',
        mensaje: 'Formato de token inválido'
      });
    }

    const token = partes[1];
    const usuario = jwt.verify(token, process.env.JWT_SECRET);

    req.usuario = usuario;

    next();

  } catch (error) {
    return res.status(401).json({
      estado: 'ERROR',
      mensaje: 'Token inválido o vencido'
    });
  }
};

module.exports = validarToken;