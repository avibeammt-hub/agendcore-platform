const baseDatos = require('../config/db');
const {
  crearOrganizationFhir,
  actualizarOrganizationFhir
} = require('../fhir/organization/organization.service');

const listarIps = async (req, res) => {
  try {
    const resultado = await baseDatos.query(`
      SELECT 
        id_ips,
        nombre,
        razon_social,
        nit,
        codigo_habilitacion,
        direccion,
        telefono,
        correo,
        activo,
        fhir_id,
        fecha_creacion
      FROM ips
      ORDER BY id_ips DESC
    `);

    res.json({
      ok: true,
      datos: resultado.rows
    });
  } catch (error) {
    console.error('Error al listar IPS:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al listar IPS'
    });
  }
};

const crearIps = async (req, res) => {
  const {
    nombre,
    razon_social,
    nit,
    codigo_habilitacion,
    direccion,
    telefono,
    correo,
    id_municipio
  } = req.body;

  try {
    // 1. Guardar en BD
    const resultado = await baseDatos.query(
      `
      INSERT INTO ips (
        nombre,
        razon_social,
        nit,
        codigo_habilitacion,
        direccion,
        telefono,
        correo,
        id_municipio
      )
      VALUES ($1,$2,$3,$4,$5,$6,$7,$8)
      RETURNING *
      `,
      [
        nombre,
        razon_social,
        nit,
        codigo_habilitacion,
        direccion,
        telefono,
        correo,
        id_municipio || null
      ]
    );

    const ipsCreada = resultado.rows[0];

    // 2. Enviar a FHIR
    const respuestaFhir = await crearOrganizationFhir(ipsCreada);

    // 3. Guardar ID FHIR
    await baseDatos.query(
      `
      UPDATE ips
      SET fhir_id = $1,
          fhir_version_id = $2,
          fecha_sincronizacion_fhir = NOW()
      WHERE id_ips = $3
      `,
      [
        respuestaFhir.id,
        respuestaFhir.meta?.versionId,
        ipsCreada.id_ips
      ]
    );

    res.status(201).json({
      ok: true,
      mensaje: 'IPS creada y sincronizada con FHIR',
      datos: {
        ...ipsCreada,
        fhir_id: respuestaFhir.id
      }
    });

  } catch (error) {

	  console.error('Error al crear IPS:', error);

	  // =========================================
	  // NIT DUPLICADO
	  // =========================================

	  if (error.code === '23505') {

		return res.status(400).json({
		  ok: false,
		  mensaje: 'El NIT ya se encuentra registrado'
		});

	  }

	  // =========================================
	  // ERROR GENERAL
	  // =========================================

	  res.status(500).json({
		ok: false,
		mensaje: 'Error interno al crear IPS'
	  });

	}
};

const actualizarIps = async (req, res) => {
  const { id } = req.params;

  const {
    nombre,
    razon_social,
    nit,
    codigo_habilitacion,
    direccion,
    telefono,
    correo
  } = req.body;

  try {
    const resultado = await baseDatos.query(
      `
      UPDATE ips
      SET 
        nombre = $1,
        razon_social = $2,
        nit = $3,
        codigo_habilitacion = $4,
        direccion = $5,
        telefono = $6,
        correo = $7
      WHERE id_ips = $8
      RETURNING *
      `,
      [
        nombre,
        razon_social,
        nit,
        codigo_habilitacion,
        direccion,
        telefono,
        correo,
        id
      ]
    );
	
	if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'IPS no encontrada'
      });
    }
	
	/* =========================================
   ACTUALIZAR FHIR
========================================= */

	if (resultado.rows[0].fhir_id) {

	  const respuestaFhir =
		await actualizarOrganizationFhir(
		  resultado.rows[0]
		);

	  await baseDatos.query(
		`
		UPDATE ips
		SET fhir_version_id = $1,
			fecha_sincronizacion_fhir = NOW()
		WHERE id_ips = $2
		`,
		[
		  respuestaFhir.meta?.versionId,
		  resultado.rows[0].id_ips
		]
	  );
	}



    res.json({
      ok: true,
      mensaje: 'IPS actualizada correctamente',
      datos: resultado.rows[0]
    });

  } catch (error) {
    console.error('Error al actualizar IPS:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al actualizar IPS'
    });
  }
};

const eliminarIps = async (req, res) => {
  const { id } = req.params;

  try {
    const resultado = await baseDatos.query(
      `
      UPDATE ips
      SET activo = false
      WHERE id_ips = $1
      RETURNING *
      `,
      [id]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'IPS no encontrada'
      });
    }

    res.json({
      ok: true,
      mensaje: 'IPS inactivada correctamente'
    });

  } catch (error) {
    console.error('Error al eliminar IPS:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al eliminar IPS'
    });
  }
};


module.exports = {
  listarIps,
  crearIps,
  actualizarIps,
  eliminarIps
};