const baseDatos = require('../config/db');
const { crearHealthcareServiceFhir } = require('../servicios/servicioFhir');

const listarServicios = async (req, res) => {
  try {
    const resultado = await baseDatos.query(`
      SELECT 
        ss.*,
        i.nombre AS nombre_ips,
        s.nombre AS nombre_sede,
        e.nombre AS nombre_especialidad
      FROM servicios_salud ss
      JOIN ips i ON i.id_ips = ss.id_ips
      JOIN sedes s ON s.id_sede = ss.id_sede
      LEFT JOIN especialidades e ON e.id_especialidad = ss.id_especialidad
      ORDER BY ss.id_servicio DESC
    `);

    res.json({
      ok: true,
      datos: resultado.rows
    });

  } catch (error) {
    console.error('Error al listar servicios:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al listar servicios'
    });
  }
};

const crearServicio = async (req, res) => {
  const {
    id_ips,
    id_sede,
    id_especialidad,
    nombre,
    descripcion
  } = req.body;

  try {
    if (!id_ips || !id_sede || !nombre) {
      return res.status(400).json({
        ok: false,
        mensaje: 'IPS, sede y nombre del servicio son obligatorios'
      });
    }

    const datos = await baseDatos.query(
      `
      SELECT 
        i.fhir_id AS fhir_id_ips,
        s.fhir_id AS fhir_id_sede,
        e.nombre AS nombre_especialidad
      FROM ips i
      JOIN sedes s ON s.id_sede = $2 AND s.id_ips = i.id_ips
      LEFT JOIN especialidades e ON e.id_especialidad = $3
      WHERE i.id_ips = $1
      `,
      [id_ips, id_sede, id_especialidad || null]
    );

    if (datos.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'No se encontró la IPS o la sede'
      });
    }

    const info = datos.rows[0];

    if (!info.fhir_id_ips || !info.fhir_id_sede) {
      return res.status(400).json({
        ok: false,
        mensaje: 'La IPS o la sede aún no están sincronizadas con FHIR'
      });
    }

    const resultado = await baseDatos.query(
      `
      INSERT INTO servicios_salud (
        id_ips,
        id_sede,
        id_especialidad,
        nombre,
        descripcion
      )
      VALUES ($1,$2,$3,$4,$5)
      RETURNING *
      `,
      [
        id_ips,
        id_sede,
        id_especialidad || null,
        nombre,
        descripcion || null
      ]
    );

    const servicio = resultado.rows[0];

    const fhir = await crearHealthcareServiceFhir({
      ...servicio,
      fhir_id_ips: info.fhir_id_ips,
      fhir_id_sede: info.fhir_id_sede,
      nombre_especialidad: info.nombre_especialidad
    });

    await baseDatos.query(
      `
      UPDATE servicios_salud
      SET fhir_id = $1,
          fhir_version_id = $2,
          fecha_sincronizacion_fhir = NOW()
      WHERE id_servicio = $3
      `,
      [fhir.id, fhir.meta?.versionId, servicio.id_servicio]
    );

    res.status(201).json({
      ok: true,
      mensaje: 'Servicio creado y sincronizado con FHIR',
      datos: {
        ...servicio,
        fhir_id: fhir.id
      }
    });

  } catch (error) {
    console.error('Error al crear servicio:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al crear servicio',
      error: error.message
    });
  }
};

const actualizarServicio = async (req, res) => {
  const { id } = req.params;
  const {
    id_ips,
    id_sede,
    id_especialidad,
    nombre,
    descripcion
  } = req.body;

  try {
    const resultado = await baseDatos.query(
      `
      UPDATE servicios_salud
      SET
        id_ips = $1,
        id_sede = $2,
        id_especialidad = $3,
        nombre = $4,
        descripcion = $5,
        fecha_actualizacion = NOW()
      WHERE id_servicio = $6
      RETURNING *
      `,
      [
        id_ips,
        id_sede,
        id_especialidad || null,
        nombre,
        descripcion || null,
        id
      ]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'Servicio no encontrado'
      });
    }

    res.json({
      ok: true,
      mensaje: 'Servicio actualizado correctamente',
      datos: resultado.rows[0]
    });

  } catch (error) {
    console.error('Error al actualizar servicio:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al actualizar servicio',
      error: error.message
    });
  }
};

const eliminarServicio = async (req, res) => {
  const { id } = req.params;

  try {
    const resultado = await baseDatos.query(
      `
      UPDATE servicios_salud
      SET 
        activo = false,
        fecha_actualizacion = NOW()
      WHERE id_servicio = $1
      RETURNING *
      `,
      [id]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'Servicio no encontrado'
      });
    }

    res.json({
      ok: true,
      mensaje: 'Servicio inactivado correctamente'
    });

  } catch (error) {
    console.error('Error al eliminar servicio:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al eliminar servicio',
      error: error.message
    });
  }
};

module.exports = {
  listarServicios,
  crearServicio,
  actualizarServicio,
  eliminarServicio
};