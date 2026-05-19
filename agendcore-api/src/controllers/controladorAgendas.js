const baseDatos = require('../config/db');
const { crearScheduleFhir } = require('../servicios/servicioFhir');

	const listarAgendas = async (req, res) => {
	  try {
		const resultado = await baseDatos.query(`
		  SELECT
			a.*,

			rp.fhir_id AS fhir_rol_profesional_id,

			p.nombres,
			p.apellidos,

			i.nombre AS nombre_ips,
			s.nombre AS nombre_sede,
			sv.nombre AS nombre_servicio

		  FROM agendas a

		  INNER JOIN roles_profesional rp
			ON rp.id_rol_profesional = a.id_rol_profesional

		  INNER JOIN profesionales p
			ON p.id_profesional = rp.id_profesional

		  INNER JOIN ips i
			ON i.id_ips = rp.id_ips

		  INNER JOIN sedes s
			ON s.id_sede = rp.id_sede

		  INNER JOIN servicios_salud sv
			ON sv.id_servicio = rp.id_servicio

		  ORDER BY a.id_agenda DESC
		`);

		res.json({
		  ok: true,
		  datos: resultado.rows
		});

	  } catch (error) {
		console.error('Error al listar agendas:', error);
		res.status(500).json({
		  ok: false,
		  mensaje: 'Error al listar agendas',
		  error: error.message
		});
	  }
	};

	const crearAgenda = async (req, res) => {
	  const {
	  id_ips,
	  id_sede,
	  id_servicio,
	  id_profesional,
	  id_rol_profesional,
	  fecha_inicio,
	  fecha_fin,
	  hora_inicio,
	  hora_fin,
	  duracion_cupo_minutos,
	  dias_semana,
	  color_agenda
	} = req.body;

	  try {
		if (!id_rol_profesional || !fecha_inicio || !fecha_fin || !hora_inicio || !hora_fin || !dias_semana) {
		  return res.status(400).json({
			ok: false,
			mensaje: 'Rol profesional, fechas, horas y días de atención son obligatorios'
		  });
		}

		const insertado = await baseDatos.query(
  `
		  INSERT INTO agendas (
			  id_ips,
			  id_sede,
			  id_servicio,
			  id_profesional,
			  id_rol_profesional,
			  id_estado_agenda,
			  fecha_inicio,
			  fecha_fin,
			  hora_inicio,
			  hora_fin,
			  duracion_cupo_minutos,
			  dias_semana,
			  color_agenda,
			  activo
			)
			VALUES ($1,$2,$3,$4,$5,1,$6,$7,$8,$9,$10,$11,$12,true)
		  RETURNING *
		  `,
		  [
			id_ips,
			id_sede,
			id_servicio,
			id_profesional,
			id_rol_profesional,
			fecha_inicio,
			fecha_fin,
			hora_inicio,
			hora_fin,
			duracion_cupo_minutos || 20,
			dias_semana,
			color_agenda || '#0d6efd'
		  ]
		);

		const idAgenda = insertado.rows[0].id_agenda;

		const consultaAgenda = await baseDatos.query(
		  `
		  SELECT
			a.*,

			rp.fhir_id AS fhir_rol_profesional_id,

			p.nombres,
			p.apellidos,

			i.nombre AS nombre_ips,
			s.nombre AS nombre_sede,
			sv.nombre AS nombre_servicio

		  FROM agendas a

		  INNER JOIN roles_profesional rp
			ON rp.id_rol_profesional = a.id_rol_profesional

		  INNER JOIN profesionales p
			ON p.id_profesional = rp.id_profesional

		  INNER JOIN ips i
			ON i.id_ips = rp.id_ips

		  INNER JOIN sedes s
			ON s.id_sede = rp.id_sede

		  INNER JOIN servicios_salud sv
			ON sv.id_servicio = rp.id_servicio

		  WHERE a.id_agenda = $1
		  `,
		  [idAgenda]
		);

		const agenda = consultaAgenda.rows[0];

		if (!agenda.fhir_rol_profesional_id) {
		  return res.status(400).json({
			ok: false,
			mensaje: 'No se puede sincronizar Schedule. La asignación profesional no tiene fhir_id.'
		  });
		}
		

		const fhir = await crearScheduleFhir(agenda);

		await baseDatos.query(
		  `
		  UPDATE agendas
		  SET
			fhir_id = $1,
			fhir_version_id = $2,
			fecha_sincronizacion_fhir = NOW()
		  WHERE id_agenda = $3
		  `,
		  [
			fhir.id,
			fhir.meta?.versionId || null,
			idAgenda
		  ]
		);

		res.status(201).json({
		  ok: true,
		  mensaje: 'Agenda creada y sincronizada como Schedule FHIR',
		  datos: {
			...agenda,
			fhir_id: fhir.id
		  }
		});

	  } catch (error) {
		console.error('Error al crear agenda:', error.response?.data || error.message);

		res.status(500).json({
		  ok: false,
		  mensaje: 'Error al crear agenda',
		  error: error.response?.data || error.message
		});
	  }
	};

	const actualizarAgenda = async (req, res) => {
	  const { id } = req.params;

	  const {
		id_rol_profesional,
		fecha_inicio,
		fecha_fin,
		hora_inicio,
		hora_fin,
		duracion_cupo_minutos,
		dias_semana,
		color_agenda
	  } = req.body;

	  try {
		const resultado = await baseDatos.query(
		  `
		  UPDATE agendas
		  SET
			id_ips = $1,
			id_sede = $2,
			id_servicio = $3,
			id_profesional = $4,
			id_rol_profesional = $5,
			fecha_inicio = $6,
			fecha_fin = $7,
			hora_inicio = $8,
			hora_fin = $9,
			duracion_cupo_minutos = $10,
			dias_semana = $11,
			color_agenda = $12,
			fecha_actualizacion = NOW()
		  WHERE id_agenda = $13
		  RETURNING *
		  `,
		  [
			id_ips,
			id_sede,
			id_servicio,
			id_profesional,
			id_rol_profesional,
			fecha_inicio,
			fecha_fin,
			hora_inicio,
			hora_fin,
			duracion_cupo_minutos || 20,
			dias_semana,
			color_agenda || '#0d6efd',
			id
		  ]
		);

		if (resultado.rows.length === 0) {
		  return res.status(404).json({
			ok: false,
			mensaje: 'Agenda no encontrada'
		  });
		}

		res.json({
		  ok: true,
		  mensaje: 'Agenda actualizada correctamente',
		  datos: resultado.rows[0]
		});

	  } catch (error) {
		console.error('Error al actualizar agenda:', error);
		res.status(500).json({
		  ok: false,
		  mensaje: 'Error al actualizar agenda',
		  error: error.message
    });
  }
	};

	const eliminarAgenda = async (req, res) => {
  const { id } = req.params;

  try {
    const resultado = await baseDatos.query(
      `
      UPDATE agendas
      SET
        activo = false,
        fecha_actualizacion = NOW()
      WHERE id_agenda = $1
      RETURNING *
      `,
      [id]
    );

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'Agenda no encontrada'
      });
    }

    res.json({
      ok: true,
      mensaje: 'Agenda inactivada correctamente'
    });

  } catch (error) {
    console.error('Error al inactivar agenda:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al inactivar agenda',
      error: error.message
    });
  }
};

module.exports = {
  listarAgendas,
  crearAgenda,
  actualizarAgenda,
  eliminarAgenda
};