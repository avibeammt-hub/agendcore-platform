const express = require('express');
const cors = require('cors');
require('dotenv').config();

const rutasIps = require('./rutas/rutasIps');
const rutasSedes = require('./rutas/rutasSedes');
const rutasProfesionales = require('./rutas/rutasProfesionales');
const rutasRolesProfesional = require('./rutas/rutasRolesProfesional');
const rutasServicios = require('./rutas/rutasServicios');
const rutasSalud = require('./rutas/rutasSalud');
const rutasAutenticacion = require('./rutas/rutasAutenticacion');
const rutasEspecialidades = require('./rutas/rutasEspecialidades');
const rutasTiposDocumento = require('./rutas/rutasTiposDocumento');
const rutasAgendas = require('./rutas/rutasAgendas');


const app = express();

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    mensaje: 'Backend Agenda FHIR funcionando correctamente'
  });
});

app.use('/api/ips', rutasIps);
app.use('/api/sedes', rutasSedes);
app.use('/api/profesionales', rutasProfesionales);
app.use('/api/roles-profesional', rutasRolesProfesional);
app.use('/api/servicios', rutasServicios);
app.use('/api/salud', rutasSalud);
app.use('/api/auth', rutasAutenticacion);
app.use('/api/especialidades', rutasEspecialidades);
app.use('/api/tipos-documento', rutasTiposDocumento);
app.use('/api/agendas', rutasAgendas);

const puerto = process.env.PUERTO || 3000;

app.listen(puerto, () => {
  console.log(`Servidor iniciado en http://localhost:${puerto}`);
});



