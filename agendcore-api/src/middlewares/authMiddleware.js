const jwt = require('jsonwebtoken');

const validarJWT = (req, res, next) => {

  try {

    const authHeader = req.headers.authorization;

    if (!authHeader) {
      return res.status(401).json({
        ok: false,
        mensaje: 'Token no enviado'
      });
    }

    if (!authHeader.startsWith('Bearer ')) {
      return res.status(401).json({
        ok: false,
        mensaje: 'Formato de token inválido'
      });
    }

    const token = authHeader.split(' ')[1];

    if (!token) {
      return res.status(401).json({
        ok: false,
        mensaje: 'Token inválido'
      });
    }

    const payload = jwt.verify(
      token,
      process.env.JWT_SECRET
    );

    req.usuario = payload;

    next();

  } catch (error) {

    console.error('Error JWT:', error);

    return res.status(401).json({
      ok: false,
      mensaje: 'Token expirado o inválido'
    });

  }

};

module.exports = {
  validarJWT
};