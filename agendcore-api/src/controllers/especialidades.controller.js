const baseDatos = require('../config/db');

const { sincronizarCodeSystemEspecialidadesFhir } = require('../servicios/servicioFhir');

const sincronizarEspecialidadesFhir = async () => {
  const resultado = await baseDatos.query(`
    SELECT id_especialidad, codigo, nombre, activo
    FROM especialidades
    ORDER BY id_especialidad
  `);

  return await sincronizarCodeSystemEspecialidadesFhir(resultado.rows);
};

const listarEspecialidades = async (req, res) => {
  try {
    const resultado = await baseDatos.query(`
      SELECT 
        id_especialidad,
        codigo,
        nombre,
        activo
      FROM especialidades
      ORDER BY id_especialidad DESC
    `);

    res.json({
      ok: true,
      datos: resultado.rows
    });

  } catch (error) {
    console.error('Error al listar especialidades:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al listar especialidades'
    });
  }
};

const crearEspecialidad = async (req, res) => {
  const { codigo, nombre } = req.body;

  try {
    if (!nombre) {
      return res.status(400).json({
        ok: false,
        mensaje: 'El nombre de la especialidad es obligatorio'
      });
    }

    const resultado = await baseDatos.query(`
      INSERT INTO especialidades (
        codigo,
        nombre
      )
      VALUES ($1,$2)
      RETURNING *
    `, [
      codigo || null,
      nombre
    ]);
	
	await sincronizarEspecialidadesFhir();

    res.status(201).json({
      ok: true,
      mensaje: 'Especialidad creada correctamente',
      datos: resultado.rows[0]
    });

  } catch (error) {
    console.error('Error al crear especialidad:', error);

    if (error.code === '23505') {
      return res.status(400).json({
        ok: false,
        mensaje: 'Ya existe una especialidad con ese código o nombre'
      });
    }

    res.status(500).json({
      ok: false,
      mensaje: 'Error al crear especialidad'
    });
  }
};

const actualizarEspecialidad = async (req, res) => {
  const { id } = req.params;
  const { codigo, nombre, activo } = req.body;

  try {
    if (!nombre) {
      return res.status(400).json({
        ok: false,
        mensaje: 'El nombre de la especialidad es obligatorio'
      });
    }

    const resultado = await baseDatos.query(`
      UPDATE especialidades
      SET
        codigo = $1,
        nombre = $2,
        activo = COALESCE($3, activo)
      WHERE id_especialidad = $4
      RETURNING *
    `, [
      codigo || null,
      nombre,
      activo,
      id
    ]);

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'Especialidad no encontrada'
      });
    }
	
	await sincronizarEspecialidadesFhir();

    res.json({
      ok: true,
      mensaje: 'Especialidad actualizada correctamente',
      datos: resultado.rows[0]
    });

  } catch (error) {
    console.error('Error al actualizar especialidad:', error);

    if (error.code === '23505') {
      return res.status(400).json({
        ok: false,
        mensaje: 'Ya existe una especialidad con ese código o nombre'
      });
    }

    res.status(500).json({
      ok: false,
      mensaje: 'Error al actualizar especialidad'
    });
  }
};

const eliminarEspecialidad = async (req, res) => {
  const { id } = req.params;

  try {
    const resultado = await baseDatos.query(`
      UPDATE especialidades
      SET activo = false
      WHERE id_especialidad = $1
      RETURNING *
    `, [id]);

    if (resultado.rows.length === 0) {
      return res.status(404).json({
        ok: false,
        mensaje: 'Especialidad no encontrada'
      });
    }
	
	await sincronizarEspecialidadesFhir();

    res.json({
      ok: true,
      mensaje: 'Especialidad inactivada correctamente'
    });

  } catch (error) {
    console.error('Error al eliminar especialidad:', error);
    res.status(500).json({
      ok: false,
      mensaje: 'Error al eliminar especialidad'
    });
  }
};



module.exports = {
  listarEspecialidades,
  crearEspecialidad,
  actualizarEspecialidad,
  eliminarEspecialidad
};