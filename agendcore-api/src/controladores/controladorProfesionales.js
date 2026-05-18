const baseDatos = require('../config/db');
const { crearPractitionerFhir } = require('../servicios/servicioFhir');

const listarProfesionales = async (req, res) => {
  try {
    const resultado = await baseDatos.query(` 
		  SELECT 
			p.*,
			e.nombre AS nombre_especialidad,
			td.codigo AS codigo_tipo_documento,
			td.descripcion AS descripcion_tipo_documento
		  FROM profesionales p

		  LEFT JOIN especialidades e
			ON e.id_especialidad = p.id_especialidad

		  LEFT JOIN tipos_documento td
			ON td.id_tipo_documento = p.id_tipo_documento

		  ORDER BY p.id_profesional DESC
		`);

    res.json({
      ok: true,
      datos: resultado.rows
    });

  } catch (error) {
    console.error('Error al listar profesionales:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al listar profesionales',
      error: error.message
    });
  }
};

const crearProfesional = async (req, res) => {
  const {
    id_tipo_documento,
    numero_documento,
    nombres,
    apellidos,
    tarjeta_profesional,
    id_especialidad,
    telefono,
    correo
  } = req.body;

  try {
    if (!nombres || !apellidos || !tarjeta_profesional || !id_especialidad) {
      return res.status(400).json({
        ok: false,
        mensaje: 'Nombres, apellidos, tarjeta profesional y especialidad son obligatorios'
      });
    }

    const existe = await baseDatos.query(
      `
      SELECT id_profesional
      FROM profesionales
      WHERE tarjeta_profesional = $1
         OR (numero_documento IS NOT NULL AND numero_documento = $2)
      LIMIT 1
      `,
      [tarjeta_profesional, numero_documento || null]
    );

    if (existe.rows.length > 0) {
      return res.status(409).json({
        ok: false,
        mensaje: 'Ya existe un profesional con la misma tarjeta profesional o número de documento'
      });
    }

    const resultado = await baseDatos.query(
      `
      INSERT INTO profesionales (
        id_tipo_documento,
        numero_documento,
        nombres,
        apellidos,
        tarjeta_profesional,
        id_especialidad,
        telefono,
        correo
      )
      VALUES ($1,$2,$3,$4,$5,$6,$7,$8)
      RETURNING *
      `,
      [
        id_tipo_documento || null,
        numero_documento || null,
        nombres.trim(),
        apellidos.trim(),
        tarjeta_profesional.trim(),
        id_especialidad,
        telefono || null,
        correo || null
      ]
    );

    const profesional = resultado.rows[0];

    const fhir = await crearPractitionerFhir(profesional);

    await baseDatos.query(
      `
      UPDATE profesionales
      SET fhir_id = $1,
          fhir_version_id = $2,
          fecha_sincronizacion_fhir = NOW()
      WHERE id_profesional = $3
      `,
      [fhir.id, fhir.meta?.versionId || null, profesional.id_profesional]
    );

    res.status(201).json({
      ok: true,
      mensaje: 'Profesional creado y sincronizado con FHIR',
      datos: {
        ...profesional,
        fhir_id: fhir.id
      }
    });

  } catch (error) {
    console.error('Error al crear profesional:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al crear profesional',
      error: error.message
    });
  }
};

const actualizarProfesional = async (req, res) => {
  const { id } = req.params;

  const {
    id_tipo_documento,
    numero_documento,
    nombres,
    apellidos,
    tarjeta_profesional,
    id_especialidad,
    telefono,
    correo
  } = req.body;

  try {
    if (!nombres || !apellidos || !tarjeta_profesional || !id_especialidad) {
      return res.status(400).json({
        ok: false,
        mensaje: 'Nombres, apellidos, tarjeta profesional y especialidad son obligatorios'
      });
    }

    const duplicado = await baseDatos.query(
      `
      SELECT id_profesional
      FROM profesionales
      WHERE id_profesional <> $1
        AND (
          tarjeta_profesional = $2
          OR (numero_documento IS NOT NULL AND numero_documento = $3)
        )
      LIMIT 1
      `,
      [id, tarjeta_profesional, numero_documento || null]
    );

    if (duplicado.rows.length > 0) {
      return res.status(409).json({
        ok: false,
        mensaje: 'Ya existe otro profesional con la misma tarjeta profesional o número de documento'
      });
    }

    const resultado = await baseDatos.query(
      `
      UPDATE profesionales
      SET
        id_tipo_documento = $1,
        numero_documento = $2,
        nombres = $3,
        apellidos = $4,
        tarjeta_profesional = $5,
        id_especialidad = $6,
        telefono = $7,
        correo = $8,
        fecha_actualizacion = NOW()
      WHERE id_profesional = $9
      RETURNING *
      `,
      [
        id_tipo_documento || null,
        numero_documento || null,
        nombres.trim(),
        apellidos.trim(),
        tarjeta_profesional.trim(),
        id_especialidad,
        telefono || null,
        correo || null,
        id
      ]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'Profesional no encontrado'
      });
    }

    res.json({
      ok: true,
      mensaje: 'Profesional actualizado correctamente',
      datos: resultado.rows[0]
    });

  } catch (error) {
    console.error('Error al actualizar profesional:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al actualizar profesional',
      error: error.message
    });
  }
};

const eliminarProfesional = async (req, res) => {
  const { id } = req.params;

  try {
    const resultado = await baseDatos.query(
      `
      UPDATE profesionales
      SET 
        activo = false,
        fecha_actualizacion = NOW()
      WHERE id_profesional = $1
      RETURNING *
      `,
      [id]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'Profesional no encontrado'
      });
    }

    res.json({
      ok: true,
      mensaje: 'Profesional inactivado correctamente'
    });

  } catch (error) {
    console.error('Error al inactivar profesional:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al inactivar profesional',
      error: error.message
    });
  }
};

module.exports = {
  listarProfesionales,
  crearProfesional,
  actualizarProfesional,
  eliminarProfesional
};