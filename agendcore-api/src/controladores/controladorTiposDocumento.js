const baseDatos = require('../config/db');

const listarTiposDocumento = async (req, res) => {
  try {
    const resultado = await baseDatos.query(`
      SELECT 
        id_tipo_documento,
        codigo,
        descripcion,
        activo
      FROM tipos_documento
      WHERE activo = true
      ORDER BY descripcion ASC
    `);

    res.json({
      ok: true,
      datos: resultado.rows
    });

  } catch (error) {
    console.error('Error al listar tipos de documento:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al listar tipos de documento',
      error: error.message
    });
  }
};

module.exports = {
  listarTiposDocumento
};