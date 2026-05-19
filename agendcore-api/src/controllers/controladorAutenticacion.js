const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const pool = require('../config/db');

const iniciarSesion = async (req, res) => {
  try {
    const { usuario, clave } = req.body;

    if (!usuario || !clave) {
      return res.status(400).json({
        estado: 'ERROR',
        mensaje: 'Usuario y clave son obligatorios'
      });
    }

    const consulta = `
      SELECT 
        u.id_usuario,
        u.nombres,
        u.apellidos,
        u.correo,
        u.usuario,
        u.clave_hash,
        u.activo,
        u.id_ips,
        u.id_sede,
        r.codigo AS codigo_rol,
        r.nombre AS nombre_rol
      FROM usuarios u
      INNER JOIN roles r ON r.id_rol = u.id_rol
      WHERE u.usuario = $1
      LIMIT 1
    `;

    const resultado = await pool.query(consulta, [usuario]);

    if (resultado.rows.length === 0) {
      return res.status(401).json({
        estado: 'ERROR',
        mensaje: 'Usuario o clave incorrectos'
      });
    }

    const usuarioBD = resultado.rows[0];

    if (!usuarioBD.activo) {
      return res.status(403).json({
        estado: 'ERROR',
        mensaje: 'El usuario se encuentra inactivo'
      });
    }

    const claveValida = await bcrypt.compare(clave, usuarioBD.clave_hash);

    if (!claveValida) {
      return res.status(401).json({
        estado: 'ERROR',
        mensaje: 'Usuario o clave incorrectos'
      });
    }

    const payload = {
      id_usuario: usuarioBD.id_usuario,
      usuario: usuarioBD.usuario,
      correo: usuarioBD.correo,
      rol: usuarioBD.codigo_rol,
      id_ips: usuarioBD.id_ips,
      id_sede: usuarioBD.id_sede
    };

    const token = jwt.sign(
      payload,
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN || '8h' }
    );

    await pool.query(
      `UPDATE usuarios 
       SET ultimo_ingreso = CURRENT_TIMESTAMP 
       WHERE id_usuario = $1`,
      [usuarioBD.id_usuario]
    );

    res.json({
      estado: 'OK',
      mensaje: 'Inicio de sesión exitoso',
      token,
      usuario: {
        id_usuario: usuarioBD.id_usuario,
        nombres: usuarioBD.nombres,
        apellidos: usuarioBD.apellidos,
        correo: usuarioBD.correo,
        usuario: usuarioBD.usuario,
        rol: usuarioBD.codigo_rol,
        nombre_rol: usuarioBD.nombre_rol,
        id_ips: usuarioBD.id_ips,
        id_sede: usuarioBD.id_sede
      }
    });

  } catch (error) {
    console.error('Error login:', error);
    res.status(500).json({
      estado: 'ERROR',
      mensaje: 'Error interno al iniciar sesión'
    });
  }
};

module.exports = {
  iniciarSesion
};