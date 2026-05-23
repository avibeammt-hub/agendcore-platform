const baseDatos = require('../config/db');
const {
  crearLocationFhir,
  actualizarLocationFhir
} = require('../fhir/location/location.service');

const crearSede = async (req, res) => {
  const {
    id_ips,
    nombre,
	identificador,
	codigo_habilitacion,
    direccion,
    telefono
  } = req.body;

  try {
    // 1. Buscar IPS
    const ips = await baseDatos.query(
      `SELECT * FROM ips WHERE id_ips = $1`,
      [id_ips]
    );

    if (ips.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'IPS no encontrada'
      });
    }

    const ipsData = ips.rows[0];

    // 2. Crear sede en BD
   const resultado = await baseDatos.query(
	  `
	  INSERT INTO sedes (
		id_ips,
		nombre,
		identificador,
		codigo_habilitacion,
		direccion,
		telefono
	  )
	  VALUES ($1,$2,$3,$4,$5,$6)
	  RETURNING *
	  `,
	  [
		id_ips,
		nombre,
		identificador,
		codigo_habilitacion || null,
		direccion || null,
		telefono || null
	  ]
	);

    
	const sede = {
	  ...resultado.rows[0],
	  activo: true
	};
    // 3. Enviar a FHIR
    const fhir = await crearLocationFhir({
      ...sede,
      ips_fhir_id: ipsData.fhir_id
    });

    // 4. Guardar ID FHIR
    await baseDatos.query(
      `
      UPDATE sedes
      SET fhir_id = $1,
          fhir_version_id = $2,
          fecha_sincronizacion_fhir = NOW()
      WHERE id_sede = $3
      `,
      [fhir.id, fhir.meta?.versionId, sede.id_sede]
    );

    res.json({
      ok: true,
      mensaje: 'Sede creada y sincronizada con FHIR'
    });

  } catch (error) {
    console.error(error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al crear sede'
    });
  }
};

const listarSedes = async (req, res) => {
  try {
    const resultado = await baseDatos.query(`
      SELECT *
      FROM sedes
	  where activo = true
      ORDER BY id_sede DESC
    `);

    res.json({
      ok: true,
      datos: resultado.rows
    });

  } catch (error) {
    console.error('Error al listar sedes:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al listar sedes'
    });
  }
};

const actualizarSede = async (req, res) => {
  const { id } = req.params;
  const {
    id_ips,
    nombre,
    identificador,
    codigo_habilitacion,
    direccion,
    telefono
  } = req.body;

  try {
    const resultado = await baseDatos.query(
      `
      UPDATE sedes
      SET 
        id_ips = $1,
        nombre = $2,
        identificador = $3,
        codigo_habilitacion = $4,
        direccion = $5,
        telefono = $6,
        fecha_actualizacion = NOW()
      WHERE id_sede = $7
      RETURNING *
      `,
      [
        id_ips,
        nombre,
        identificador,
        codigo_habilitacion || null,
        direccion || null,
        telefono || null,
        id
      ]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'Sede no encontrada'
      });
    }
	
	/* =========================================
	   ACTUALIZAR FHIR
	========================================= */

	if (resultado.rows[0].fhir_id) {

	  const ips = await baseDatos.query(
		`
		SELECT fhir_id
		FROM ips
		WHERE id_ips = $1
		`,
		[resultado.rows[0].id_ips]
	  );

	  const respuestaFhir =
		await actualizarLocationFhir({

		  ...resultado.rows[0],

		  ips_fhir_id:
			ips.rows[0]?.fhir_id

		});

	  await baseDatos.query(
		`
		UPDATE sedes
		SET
		  fhir_version_id = $1,
		  fecha_sincronizacion_fhir = NOW()
		WHERE id_sede = $2
		`,
		[
		  respuestaFhir.meta?.versionId,
		  resultado.rows[0].id_sede
		]
	  );
	}

    res.json({
      ok: true,
      mensaje: 'Sede actualizada correctamente',
      datos: resultado.rows[0]
    });

  } catch (error) {
    console.error('Error al actualizar sede:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al actualizar sede'
    });
  }
};

const eliminarSede = async (req, res) => {
  const { id } = req.params;

  try {
    const resultado = await baseDatos.query(
      `
      UPDATE sedes
      SET activo = false,
          fecha_actualizacion = NOW()
      WHERE id_sede = $1
      RETURNING *
      `,
      [id]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'Sede no encontrada'
      });
    }
	
	/* =========================================
	   INACTIVAR FHIR
	========================================= */

	if (resultado.rows[0].fhir_id) {

	  const ips = await baseDatos.query(
		`
		SELECT fhir_id
		FROM ips
		WHERE id_ips = $1
		`,
		[resultado.rows[0].id_ips]
	  );

	  await actualizarLocationFhir({

		...resultado.rows[0],

		ips_fhir_id:
		  ips.rows[0]?.fhir_id

	  });

	  await baseDatos.query(
		`
		UPDATE sedes
		SET fecha_sincronizacion_fhir = NOW()
		WHERE id_sede = $1
		`,
		[resultado.rows[0].id_sede]
	  );
	}

    res.json({
      ok: true,
      mensaje: 'Sede inactivada correctamente'
    });

  } catch (error) {
    console.error('Error al eliminar sede:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al eliminar sede'
    });
  }
};


module.exports = {
  crearSede,
  listarSedes,
  actualizarSede,
  eliminarSede
};