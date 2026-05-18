const baseDatos = require('../config/db');
const { crearPractitionerRoleFhir } = require('../servicios/servicioFhir');

const listarRolesProfesional = async (req, res) => {
  try {
    const resultado = await baseDatos.query(`
      SELECT
        rp.*,

        p.nombres,
        p.apellidos,
        p.fhir_id AS fhir_profesional_id,

        i.nombre AS nombre_ips,
        i.fhir_id AS fhir_ips_id,

        s.nombre AS nombre_sede,
        s.fhir_id AS fhir_sede_id,

        sv.nombre AS nombre_servicio,
        sv.fhir_id AS fhir_servicio_id

      FROM roles_profesional rp

      INNER JOIN profesionales p
        ON p.id_profesional = rp.id_profesional

      INNER JOIN ips i
        ON i.id_ips = rp.id_ips

      INNER JOIN sedes s
        ON s.id_sede = rp.id_sede

      INNER JOIN servicios_salud sv
        ON sv.id_servicio = rp.id_servicio

      ORDER BY rp.id_rol_profesional DESC
    `);

    res.json({
      ok: true,
      datos: resultado.rows
    });

  } catch (error) {
    console.error('Error al listar roles profesional:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al listar roles profesional',
      error: error.message
    });
  }
};

const crearRolProfesional = async (req, res) => {
  const {
    id_profesional,
    id_ips,
    id_sede,
    id_servicio,
    fecha_inicio,
    fecha_fin,
    jornada
  } = req.body;

  try {
    if (!id_profesional || !id_ips || !id_sede || !id_servicio || !fecha_inicio) {
      return res.status(400).json({
        ok: false,
        mensaje: 'Profesional, IPS, sede, servicio y fecha inicio son obligatorios'
      });
    }

    const duplicado = await baseDatos.query(
      `
      SELECT id_rol_profesional
      FROM roles_profesional
      WHERE id_profesional = $1
        AND id_ips = $2
        AND id_sede = $3
        AND id_servicio = $4
        AND activo = true
      LIMIT 1
      `,
      [id_profesional, id_ips, id_sede, id_servicio]
    );

    if (duplicado.rows.length > 0) {
      return res.status(409).json({
        ok: false,
        mensaje: 'Ya existe una asignación activa para este profesional, IPS, sede y servicio'
      });
    }

    const insertado = await baseDatos.query(
      `
      INSERT INTO roles_profesional (
        id_profesional,
        id_ips,
        id_sede,
        id_servicio,
        fecha_inicio,
        fecha_fin,
        jornada
      )
      VALUES ($1,$2,$3,$4,$5,$6,$7)
      RETURNING *
      `,
      [
        id_profesional,
        id_ips,
        id_sede,
        id_servicio,
        fecha_inicio,
        fecha_fin || null,
        jornada || null
      ]
    );

    const idRol = insertado.rows[0].id_rol_profesional;

    const consultaRol = await baseDatos.query(
      `
      SELECT
        rp.*,

        p.nombres,
        p.apellidos,
        p.fhir_id AS fhir_profesional_id,

        i.nombre AS nombre_ips,
        i.fhir_id AS fhir_ips_id,

        s.nombre AS nombre_sede,
        s.fhir_id AS fhir_sede_id,

        sv.nombre AS nombre_servicio,
        sv.fhir_id AS fhir_servicio_id

      FROM roles_profesional rp

      INNER JOIN profesionales p ON p.id_profesional = rp.id_profesional
      INNER JOIN ips i ON i.id_ips = rp.id_ips
      INNER JOIN sedes s ON s.id_sede = rp.id_sede
      INNER JOIN servicios_salud sv ON sv.id_servicio = rp.id_servicio

      WHERE rp.id_rol_profesional = $1
      `,
      [idRol]
    );

    const rol = consultaRol.rows[0];

    if (
      !rol.fhir_profesional_id ||
      !rol.fhir_ips_id ||
      !rol.fhir_sede_id ||
      !rol.fhir_servicio_id
    ) {
      return res.status(400).json({
        ok: false,
        mensaje: 'No se puede sincronizar con FHIR. Verifica que profesional, IPS, sede y servicio tengan fhir_id.'
      });
    }

    const fhir = await crearPractitionerRoleFhir(rol);

    await baseDatos.query(
      `
      UPDATE roles_profesional
      SET
        fhir_id = $1,
        fhir_version_id = $2,
        fecha_sincronizacion_fhir = NOW()
      WHERE id_rol_profesional = $3
      `,
      [
        fhir.id,
        fhir.meta?.versionId || null,
        idRol
      ]
    );

    res.status(201).json({
      ok: true,
      mensaje: 'Asignación profesional creada y sincronizada con FHIR',
      datos: {
        ...rol,
        fhir_id: fhir.id
      }
    });

  } catch (error) {
  console.error('Error al crear rol profesional:', error.response?.data || error.message);

  res.status(500).json({
    ok: false,
    mensaje: 'Error al crear asignación profesional',
    error: error.response?.data || error.message
  });
}
};

const actualizarRolProfesional = async (req, res) => {
  const { id } = req.params;

  const {
    id_profesional,
    id_ips,
    id_sede,
    id_servicio,
    fecha_inicio,
    fecha_fin,
    jornada
  } = req.body;

  try {
    const resultado = await baseDatos.query(
      `
      UPDATE roles_profesional
      SET
        id_profesional = $1,
        id_ips = $2,
        id_sede = $3,
        id_servicio = $4,
        fecha_inicio = $5,
        fecha_fin = $6,
        jornada = $7,
        fecha_actualizacion = NOW()
      WHERE id_rol_profesional = $8
      RETURNING *
      `,
      [
        id_profesional,
        id_ips,
        id_sede,
        id_servicio,
        fecha_inicio,
        fecha_fin || null,
        jornada || null,
        id
      ]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'Asignación profesional no encontrada'
      });
    }

    res.json({
      ok: true,
      mensaje: 'Asignación profesional actualizada correctamente',
      datos: resultado.rows[0]
    });

  } catch (error) {
    console.error('Error al actualizar rol profesional:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al actualizar asignación profesional',
      error: error.message
    });
  }
};

const eliminarRolProfesional = async (req, res) => {
  const { id } = req.params;

  try {
    const resultado = await baseDatos.query(
      `
      UPDATE roles_profesional
      SET
        activo = false,
        fecha_actualizacion = NOW()
      WHERE id_rol_profesional = $1
      RETURNING *
      `,
      [id]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'Asignación profesional no encontrada'
      });
    }

    res.json({
      ok: true,
      mensaje: 'Asignación profesional inactivada correctamente'
    });

  } catch (error) {
    console.error('Error al inactivar rol profesional:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al inactivar asignación profesional',
      error: error.message
    });
  }
};

module.exports = {
  listarRolesProfesional,
  crearRolProfesional,
  actualizarRolProfesional,
  eliminarRolProfesional
};