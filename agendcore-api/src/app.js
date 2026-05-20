const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

const rutasIps = require('./routes/ips.routes');
//const rutasSedes = require('./routes/sedes.routes');
//const rutasProfesionales = require('./routes/profesionales.routes');
//const rutasRolesProfesional = require('./routes/rolesProfesional.routes');
//const rutasServicios = require('./routes/servicios.routes');
//const rutasSalud = require('./routes/salud.routes');
const rutasAutenticacion = require('./routes/auth.routes');
//const rutasEspecialidades = require('./routes/especialidades.routes');
//const rutasTiposDocumento = require('./routes/tiposDocumento.routes');
//const rutasAgendas = require('./routes/agendas.routes');





app.get('/', (req, res) => {
  res.json({
    ok: true,
    mensaje: 'AgendCore API funcionando correctamente'
  });
});

app.use('/api/ips', rutasIps);
//app.use('/api/sedes', rutasSedes);
//app.use('/api/profesionales', rutasProfesionales);
//app.use('/api/roles-profesional', rutasRolesProfesional);
//app.use('/api/servicios', rutasServicios);
//app.use('/api/salud', rutasSalud);
app.use('/api/auth', rutasAutenticacion);
//app.use('/api/especialidades', rutasEspecialidades);
//app.use('/api/tipos-documento', rutasTiposDocumento);
//app.use('/api/agendas', rutasAgendas);

module.exports = app;