const contenido = document.getElementById('contenido');
const titulo = document.getElementById('tituloVista');
const subtitulo = document.getElementById('subtituloVista');
const nombreUsuario = document.getElementById('nombreUsuario');

const token = localStorage.getItem('token');
const usuario = JSON.parse(localStorage.getItem('usuarioSesion'));

// =========================
// VALIDAR SESIÓN
// =========================

if (!token || !usuario) {
  window.location.href = 'index.html';
}

nombreUsuario.textContent =
  usuario.nombres && usuario.apellidos
    ? `${usuario.nombres} ${usuario.apellidos}`
    : usuario.usuario || 'Usuario';

// =========================
// HEADERS AUTH
// =========================

function headersAuth() {
  return {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${token}`
  };
}

// =========================
// VALIDAR TOKEN
// =========================

function validarRespuestaNoAutorizada(res) {

  if (res.status === 401 || res.status === 403) {

    localStorage.removeItem('token');
    localStorage.removeItem('usuarioSesion');

    window.location.href = 'index.html';

    return true;
  }

  return false;
}

// =========================
// CAMBIAR VISTAS
// =========================

function cargarVista(vista) {

 document
  .querySelectorAll('.menu li')
  .forEach(el => el.classList.remove('active'));

const menuActivo = document.querySelector(
  `.menu li[onclick="cargarVista('${vista}')"]`
);

if (menuActivo) {
  menuActivo.classList.add('active');
}

  // =========================
  // INICIO
  // =========================

  if (vista === 'inicio') {

    titulo.textContent = 'Inicio';
    subtitulo.textContent = 'Panel principal';

    contenido.innerHTML = `
      <div class="row g-4">

        <div class="col-md-4">
          <div class="card shadow-sm border-0 rounded-4 p-4">
            <h6 class="text-muted mb-2">IPS</h6>
            <h2 class="fw-bold" id="totalIps">--</h2>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card shadow-sm border-0 rounded-4 p-4">
            <h6 class="text-muted mb-2">Sedes</h6>
            <h2 class="fw-bold" id="totalSedes">--</h2>
          </div>
        </div>

        <div class="col-md-4">
          <div class="card shadow-sm border-0 rounded-4 p-4">
            <h6 class="text-muted mb-2">Servicios</h6>
            <h2 class="fw-bold" id="totalServicios">--</h2>
          </div>
        </div>

      </div>
    `;

    cargarResumenInicio();
  }

  // =========================
  // IPS
  // =========================

  if (vista === 'ips') {

    titulo.textContent = 'IPS';

    subtitulo.textContent =
      'Administración de Instituciones Prestadoras de Servicios';

    cargarIps();
  }

  // =========================
  // SEDES
  // =========================

  if (vista === 'sedes') {

    titulo.textContent = 'Sedes';

    subtitulo.textContent =
      'Administración de sedes';

    contenido.innerHTML = `
      <div class="alert alert-info rounded-4">
        Módulo de sedes en construcción
      </div>
    `;
  }

  // =========================
  // ESPECIALIDADES
  // =========================

  if (vista === 'especialidades') {

    titulo.textContent = 'Especialidades';

    subtitulo.textContent =
      'Administración de especialidades';

    contenido.innerHTML = `
      <div class="alert alert-info rounded-4">
        Módulo de especialidades en construcción
      </div>
    `;
  }

  // =========================
  // SERVICIOS
  // =========================

  if (vista === 'servicios') {

    titulo.textContent = 'Servicios';

    subtitulo.textContent =
      'Administración de servicios';

    contenido.innerHTML = `
      <div class="alert alert-info rounded-4">
        Módulo de servicios en construcción
      </div>
    `;
  }

  // =========================
  // PROFESIONALES
  // =========================

  if (vista === 'profesionales') {

    titulo.textContent = 'Profesionales';

    subtitulo.textContent =
      'Administración de profesionales';

    contenido.innerHTML = `
      <div class="alert alert-info rounded-4">
        Módulo de profesionales en construcción
      </div>
    `;
  }

  // =========================
  // ROLES
  // =========================

  if (vista === 'roles-profesional') {

    titulo.textContent = 'Asignación Profesional';

    subtitulo.textContent =
      'Relación profesional IPS sede servicio';

    contenido.innerHTML = `
      <div class="alert alert-info rounded-4">
        Módulo de asignaciones en construcción
      </div>
    `;
  }

  // =========================
  // AGENDAS
  // =========================

  if (vista === 'agendas') {

    titulo.textContent = 'Agendas';

    subtitulo.textContent =
      'FHIR Schedule mensual';

    contenido.innerHTML = `
      <div class="alert alert-info rounded-4">
        Módulo de agendas en construcción
      </div>
    `;
  }
}

// =========================
// RESUMEN DASHBOARD
// =========================

async function cargarResumenInicio() {

  try {

    const [
      resIps,
      resSedes,
      resServicios
    ] = await Promise.all([

      fetch(`${API_BASE}/ips`, {
        headers: headersAuth()
      }),

      fetch(`${API_BASE}/sedes`, {
        headers: headersAuth()
      }),

      fetch(`${API_BASE}/servicios`, {
        headers: headersAuth()
      })

    ]);

    if (
      validarRespuestaNoAutorizada(resIps) ||
      validarRespuestaNoAutorizada(resSedes) ||
      validarRespuestaNoAutorizada(resServicios)
    ) return;

    const dataIps = await resIps.json();
    const dataSedes = await resSedes.json();
    const dataServicios = await resServicios.json();

    document.getElementById('totalIps').textContent =
      dataIps.datos ? dataIps.datos.length : 0;

    document.getElementById('totalSedes').textContent =
      dataSedes.datos ? dataSedes.datos.length : 0;

    document.getElementById('totalServicios').textContent =
      dataServicios.datos ? dataServicios.datos.length : 0;

  } catch (error) {

    console.error(error);
  }
}

// =========================
// CERRAR SESIÓN
// =========================

function cerrarSesion() {

  localStorage.removeItem('token');
  localStorage.removeItem('usuarioSesion');

  window.location.href = 'index.html';
}

// =========================
// INICIO APP
// =========================

document.addEventListener('DOMContentLoaded', () => {

  cargarVista('inicio');

});