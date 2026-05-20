
const contenido = document.getElementById('contenido');
const titulo = document.getElementById('tituloVista');
const subtitulo = document.getElementById('subtituloVista');
const nombreUsuario = document.getElementById('nombreUsuario');

const token = localStorage.getItem('token');
const usuario = JSON.parse(localStorage.getItem('usuarioSesion'));

if (!token || !usuario) {
  window.location.href = 'index.html';
}

nombreUsuario.textContent =
  usuario.nombres && usuario.apellidos
    ? `${usuario.nombres} ${usuario.apellidos}`
    : usuario.usuario || 'Usuario';

function headersAuth() {
  return {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${token}`
  };
}

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
// VISTAS
// =========================

function cargarVista(vista) {
  document.querySelectorAll('.menu li').forEach(el => el.classList.remove('active'));

  if (window.event && window.event.currentTarget) {
    window.event.currentTarget.classList.add('active');
  }

  if (vista === 'inicio') {
    titulo.textContent = 'Inicio';
    subtitulo.textContent = 'Panel principal';

    contenido.innerHTML = `
      <div class="row g-4">
        <div class="col-md-3">
          <div class="card p-3 shadow-sm border-0">
            <h6>IPS</h6>
            <h3 id="totalIps">--</h3>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card p-3 shadow-sm border-0">
            <h6>Sedes</h6>
            <h3 id="totalSedes">--</h3>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card p-3 shadow-sm border-0">
            <h6>Servicios</h6>
            <h3 id="totalServicios">--</h3>
          </div>
        </div>
      </div>
    `;

    cargarResumenInicio();
  }

  if (vista === 'ips') {
    titulo.textContent = 'IPS';
    subtitulo.textContent = 'Administración de Instituciones Prestadoras de Servicios';

    contenido.innerHTML = `
      <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h4 class="fw-bold mb-1">Gestión de IPS</h4>
          <small class="text-muted">Crear, editar y consultar IPS sincronizadas con FHIR</small>
        </div>
        <button class="btn btn-primary" onclick="abrirModalIps()">
          <i class="bi bi-plus-circle me-1"></i> Nueva IPS
        </button>
      </div>

      <div class="card shadow-sm border-0">
        <div class="card-body">
          <div id="tablaIps">Cargando IPS...</div>
        </div>
      </div>

      ${htmlModalIps()}
    `;

    cargarIps();
  }

  if (vista === 'sedes') {
    titulo.textContent = 'Sedes';
    subtitulo.textContent = 'Administración de sedes por IPS';

    contenido.innerHTML = `
      <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h4 class="fw-bold mb-1">Gestión de Sedes</h4>
          <small class="text-muted">Crear sedes asociadas a una IPS y sincronizarlas con FHIR Location</small>
        </div>
        <button class="btn btn-primary" onclick="abrirModalSede()">
          <i class="bi bi-plus-circle me-1"></i> Nueva Sede
        </button>
      </div>

      <div class="card shadow-sm border-0">
        <div class="card-body">
          <div id="tablaSedes">Cargando sedes...</div>
        </div>
      </div>

      ${htmlModalSede()}
    `;

    cargarSedes();
  }

  if (vista === 'especialidades') {
  titulo.textContent = 'Especialidades';
  subtitulo.textContent = 'Administración de especialidades';

  contenido.innerHTML = `
    <div class="d-flex justify-content-between align-items-center mb-4">
      <div>
        <h4 class="fw-bold mb-1">Gestión de Especialidades</h4>
        <small class="text-muted">Administración de catálogo clínico</small>
      </div>
      <button class="btn btn-primary" onclick="abrirModalEspecialidad()">
        <i class="bi bi-plus-circle me-1"></i> Nueva Especialidad
      </button>
    </div>

    <div class="card shadow-sm border-0">
      <div class="card-body">
        <div id="tablaEspecialidades">Cargando...</div>
      </div>
    </div>

    ${htmlModalEspecialidad()}
  `;

  cargarEspecialidades();
}

  if (vista === 'servicios') {
    titulo.textContent = 'Servicios';
    subtitulo.textContent = 'Administración de servicios de salud';

    contenido.innerHTML = `
      <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h4 class="fw-bold mb-1">Gestión de Servicios</h4>
          <small class="text-muted">Crear servicios asociados a una IPS y sede, sincronizados como HealthcareService</small>
        </div>
        <button class="btn btn-primary" onclick="abrirModalServicio()">
          <i class="bi bi-plus-circle me-1"></i> Nuevo Servicio
        </button>
      </div>

      <div class="card shadow-sm border-0">
        <div class="card-body">
          <div id="tablaServicios">Cargando servicios...</div>
        </div>
      </div>

      ${htmlModalServicio()}
    `;

    cargarServicios();
  }

  if (vista === 'profesionales') {
  titulo.textContent = 'Profesionales';
  subtitulo.textContent = 'Administración de profesionales de salud';

  contenido.innerHTML = `
    <div class="d-flex justify-content-between align-items-center mb-4">
      <div>
        <h4 class="fw-bold mb-1">Gestión de Profesionales</h4>
        <small class="text-muted">Crear, editar y sincronizar profesionales como Practitioner en FHIR</small>
      </div>
      <button class="btn btn-primary" onclick="abrirModalProfesional()">
        <i class="bi bi-plus-circle me-1"></i> Nuevo Profesional
      </button>
    </div>

    <div class="card shadow-sm border-0">
      <div class="card-body">
        <div id="tablaProfesionales">Cargando profesionales...</div>
      </div>
    </div>

    ${htmlModalProfesional()}
  `;

  cargarProfesionales();
}

  if (vista === 'roles-profesional') {

  titulo.textContent = 'Asignación Profesional';
  subtitulo.textContent = 'Relación profesional IPS sede servicio';

  contenido.innerHTML = `
    <div class="d-flex justify-content-between align-items-center mb-4">

      <div>
        <h4 class="fw-bold mb-1">
          Gestión de Asignaciones
        </h4>

        <small class="text-muted">
          PractitionerRole FHIR R4
        </small>
      </div>

      <button class="btn btn-primary" onclick="abrirModalRolProfesional()">
        <i class="bi bi-plus-circle me-1"></i>
        Nueva Asignación
      </button>

    </div>

    <div class="card shadow-sm border-0">
      <div class="card-body">
        <div id="tablaRolesProfesional">
          Cargando asignaciones...
        </div>
      </div>
    </div>

    ${htmlModalRolProfesional()}
  `;

  cargarRolesProfesional();
}

  if (vista === 'agendas') {

  titulo.textContent = 'Agendas';
  subtitulo.textContent = 'FHIR Schedule mensual';

  contenido.innerHTML = `
    <div class="d-flex justify-content-between align-items-center mb-4">

      <div>
        <h4 class="fw-bold mb-1">
          Gestión de Agendas
        </h4>

        <small class="text-muted">
          Schedule FHIR por profesional y servicio
        </small>
      </div>

      <button class="btn btn-primary" onclick="abrirModalAgenda()">
        <i class="bi bi-plus-circle me-1"></i>
        Nueva Agenda
      </button>

    </div>

    <div class="card shadow-sm border-0">

      <div class="card-body">

        <div id="tablaAgendas">
          Cargando agendas...
        </div>

      </div>

    </div>

    ${htmlModalAgenda()}
  `;

  cargarAgendas();
}

}

// =========================
// MODALES
// =========================

function htmlModalIps() {
  return `
    <div class="modal fade" id="modalIps" tabindex="-1">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 rounded-4">
          <div class="modal-header bg-primary text-white rounded-top-4">
            <h5 class="modal-title" id="tituloModalIps">Nueva IPS</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <input type="hidden" id="id_ips">
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label">Nombre *</label>
                <input id="nombre_ips" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Razón social</label>
                <input id="razon_social_ips" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">NIT *</label>
                <input id="nit_ips" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Código habilitación</label>
                <input id="codigo_habilitacion_ips" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Teléfono</label>
                <input id="telefono_ips" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Correo</label>
                <input id="correo_ips" class="form-control">
              </div>
              <div class="col-12">
                <label class="form-label">Dirección</label>
                <input id="direccion_ips" class="form-control">
              </div>
            </div>
            <div id="mensajeIps" class="alert d-none mt-3"></div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
            <button class="btn btn-primary" onclick="guardarIps()">
              <i class="bi bi-save me-1"></i> Guardar
            </button>
          </div>
        </div>
      </div>
    </div>
  `;
}

function htmlModalSede() {
  return `
    <div class="modal fade" id="modalSede" tabindex="-1">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 rounded-4">
          <div class="modal-header bg-primary text-white rounded-top-4">
            <h5 class="modal-title" id="tituloModalSede">Nueva Sede</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>
          <div class="modal-body">
            <input type="hidden" id="id_sede">
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label">IPS *</label>
                <select id="id_ips_sede" class="form-select"></select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Nombre sede *</label>
                <input id="nombre_sede" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Identificador *</label>
                <input id="identificador_sede" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Código habilitación</label>
                <input id="codigo_habilitacion_sede" class="form-control">
              </div>
              <div class="col-md-6">
                <label class="form-label">Teléfono</label>
                <input id="telefono_sede" class="form-control">
              </div>
              <div class="col-12">
                <label class="form-label">Dirección</label>
                <input id="direccion_sede" class="form-control">
              </div>
            </div>
            <div id="mensajeSede" class="alert d-none mt-3"></div>
          </div>
          <div class="modal-footer">
            <button class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
            <button class="btn btn-primary" onclick="guardarSede()">
              <i class="bi bi-save me-1"></i> Guardar
            </button>
          </div>
        </div>
      </div>
    </div>
  `;
}

function htmlModalServicio() {
  return `
    <div class="modal fade" id="modalServicio" tabindex="-1">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 rounded-4">
          <div class="modal-header bg-primary text-white rounded-top-4">
            <h5 class="modal-title" id="tituloModalServicio">Nuevo Servicio</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>

          <div class="modal-body">
            <input type="hidden" id="id_servicio">

            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label">IPS *</label>
                <select id="id_ips_servicio"
						class="form-select"
						onchange="cargarSedesServicioPorIps()">
				</select>
              </div>

              <div class="col-md-6">
                <label class="form-label">Sede *</label>
                <select id="id_sede_servicio" class="form-select"></select>
              </div>

              <div class="col-md-6">
                <label class="form-label">Especialidad</label>
                <select id="id_especialidad_servicio" class="form-select">
                  <option value="">Sin especialidad</option>
                </select>
              </div>

              <div class="col-md-6">
                <label class="form-label">Nombre del servicio *</label>
                <input id="nombre_servicio" class="form-control" placeholder="Ej: Consulta Medicina General">
              </div>

              <div class="col-12">
                <label class="form-label">Descripción</label>
                <textarea id="descripcion_servicio" class="form-control" rows="3"></textarea>
              </div>
            </div>

            <div id="mensajeServicio" class="alert d-none mt-3"></div>
          </div>

          <div class="modal-footer">
            <button class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
            <button class="btn btn-primary" onclick="guardarServicio()">
              <i class="bi bi-save me-1"></i> Guardar
            </button>
          </div>
        </div>
      </div>
    </div>
  `;
}

function htmlModalEspecialidad() {
  return `
    <div class="modal fade" id="modalEspecialidad" tabindex="-1">
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 rounded-4">

          <div class="modal-header bg-primary text-white">
            <h5 class="modal-title" id="tituloModalEspecialidad">Nueva Especialidad</h5>
            <button class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>

          <div class="modal-body">
            <input type="hidden" id="id_especialidad">

            <div class="mb-3">
              <label class="form-label">Código</label>
              <input id="codigo_especialidad" class="form-control">
            </div>

            <div class="mb-3">
              <label class="form-label">Nombre *</label>
              <input id="nombre_especialidad" class="form-control">
            </div>

            <div id="mensajeEspecialidad" class="alert d-none"></div>
          </div>

          <div class="modal-footer">
            <button class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
            <button class="btn btn-primary" onclick="guardarEspecialidad()">Guardar</button>
          </div>

        </div>
      </div>
    </div>
  `;
}

function htmlModalProfesional() {
  return `
    <div class="modal fade" id="modalProfesional" tabindex="-1">
      <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 rounded-4">

          <div class="modal-header bg-primary text-white rounded-top-4">
            <h5 class="modal-title" id="tituloModalProfesional">Nuevo Profesional</h5>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
          </div>

          <div class="modal-body">
            <input type="hidden" id="id_profesional">

            <div class="row g-3">

              <div class="col-md-6">
                <label class="form-label">Nombres *</label>
                <input id="nombres_profesional" class="form-control">
              </div>

              <div class="col-md-6">
                <label class="form-label">Apellidos *</label>
                <input id="apellidos_profesional" class="form-control">
              </div>

              <div class="col-md-4">
                <label class="form-label">Tipo documento</label>
					<select id="id_tipo_documento_profesional" class="form-select">
					  <option value="">Seleccione un tipo</option>
					</select>
              </div>

              <div class="col-md-4">
                <label class="form-label">Número documento</label>
                <input id="numero_documento_profesional" class="form-control">
              </div>

              <div class="col-md-4">
                <label class="form-label">Tarjeta profesional *</label>
                <input id="tarjeta_profesional" class="form-control">
              </div>

              <div class="col-md-6">
                <label class="form-label">Especialidad *</label>
                <select id="id_especialidad_profesional" class="form-select">
                  <option value="">Seleccione una especialidad</option>
                </select>
              </div>

              <div class="col-md-3">
                <label class="form-label">Teléfono</label>
                <input id="telefono_profesional" class="form-control">
              </div>

              <div class="col-md-3">
                <label class="form-label">Correo</label>
                <input id="correo_profesional" class="form-control">
              </div>

            </div>

            <div id="mensajeProfesional" class="alert d-none mt-3"></div>
          </div>

          <div class="modal-footer">
            <button class="btn btn-light" data-bs-dismiss="modal">Cancelar</button>
            <button class="btn btn-primary" onclick="guardarProfesional()">
              <i class="bi bi-save me-1"></i> Guardar
            </button>
          </div>

        </div>
      </div>
    </div>
  `;
}

function htmlModalRolProfesional() {

  return `
    <div class="modal fade" id="modalRolProfesional" tabindex="-1">

      <div class="modal-dialog modal-xl modal-dialog-centered">

        <div class="modal-content border-0 rounded-4">

          <div class="modal-header bg-primary text-white rounded-top-4">

            <h5 class="modal-title" id="tituloModalRolProfesional">
              Nueva Asignación Profesional
            </h5>

            <button
              type="button"
              class="btn-close btn-close-white"
              data-bs-dismiss="modal">
            </button>

          </div>

          <div class="modal-body">

            <input type="hidden" id="id_rol_profesional">

            <div class="row g-3">

              <div class="col-md-6">
                <label class="form-label">Profesional *</label>
                <select id="id_profesional_rol" class="form-select"></select>
              </div>

              <div class="col-md-6">
                <label class="form-label">IPS *</label>
                <select
                  id="id_ips_rol"
                  class="form-select"
                  onchange="cargarSedesRolProfesional()">
                </select>
              </div>

              <div class="col-md-6">
                <label class="form-label">Sede *</label>
                <select
                  id="id_sede_rol"
                  class="form-select"
                  onchange="cargarServiciosRolProfesional()">
                </select>
              </div>

              <div class="col-md-6">
                <label class="form-label">Servicio *</label>
                <select id="id_servicio_rol" class="form-select"></select>
              </div>

              <div class="col-md-4">
                <label class="form-label">Fecha inicio *</label>
                <input
                  type="date"
                  id="fecha_inicio_rol"
                  class="form-control">
              </div>

              <div class="col-md-4">
                <label class="form-label">Fecha fin</label>
                <input
                  type="date"
                  id="fecha_fin_rol"
                  class="form-control">
              </div>

              <div class="col-md-4">
                <label class="form-label">Jornada</label>
                <input
                  id="jornada_rol"
                  class="form-control"
                  placeholder="Ej: L-V 7am-1pm">
              </div>

            </div>

            <div id="mensajeRolProfesional" class="alert d-none mt-3"></div>

          </div>

          <div class="modal-footer">

            <button
              class="btn btn-light"
              data-bs-dismiss="modal">

              Cancelar

            </button>

            <button
              class="btn btn-primary"
              onclick="guardarRolProfesional()">

              <i class="bi bi-save me-1"></i>
              Guardar

            </button>

          </div>

        </div>

      </div>

    </div>
  `;
}

function htmlModalAgenda() {

  return `
    <div class="modal fade" id="modalAgenda" tabindex="-1">

      <div class="modal-dialog modal-xl modal-dialog-centered">

        <div class="modal-content border-0 rounded-4">

          <div class="modal-header bg-primary text-white rounded-top-4">

            <h5 class="modal-title" id="tituloModalAgenda">
              Nueva Agenda
            </h5>

            <button
              type="button"
              class="btn-close btn-close-white"
              data-bs-dismiss="modal">
            </button>

          </div>

          <div class="modal-body">

            <input type="hidden" id="id_agenda">

            <div class="row g-3">

              <input type="hidden" id="id_rol_profesional_agenda">

			  <div class="col-md-3">
				  <label class="form-label">IPS *</label>
				  <select id="id_ips_agenda"
						  class="form-select"
						  onchange="cargarSedesAgendaCascada()">
				  </select>
			  </div>

			  <div class="col-md-3">
				  <label class="form-label">Sede *</label>
				  <select id="id_sede_agenda"
						  class="form-select"
						  onchange="cargarServiciosAgendaCascada()">
				  </select>
			  </div>
  
			  <div class="col-md-3">
				  <label class="form-label">Servicio *</label>
				  <select id="id_servicio_agenda"
						  class="form-select"
						  onchange="cargarProfesionalesAgendaCascada()">
				  </select>
			  </div>

			  <div class="col-md-3">
				  <label class="form-label">Profesional *</label>
				  <select id="id_profesional_agenda"
						  class="form-select"
						  onchange="resolverRolProfesionalAgenda()">
				  </select>
			  </div>

              <div class="col-md-3">
                <label class="form-label">Fecha inicio *</label>

                <input type="date"
                       id="fecha_inicio_agenda"
                       class="form-control">
              </div>

              <div class="col-md-3">
                <label class="form-label">Fecha fin *</label>

                <input type="date"
                       id="fecha_fin_agenda"
                       class="form-control">
              </div>

              <div class="col-md-3">
                <label class="form-label">Hora inicio *</label>

                <input type="time"
                       id="hora_inicio_agenda"
                       class="form-control">
              </div>

              <div class="col-md-3">
                <label class="form-label">Hora fin *</label>

                <input type="time"
                       id="hora_fin_agenda"
                       class="form-control">
              </div>

              <div class="col-md-3">
                <label class="form-label">Duración cupo (min)</label>

                <input type="number"
                       id="duracion_cupo_agenda"
                       class="form-control"
                       value="20">
              </div>

              <div class="col-md-3">
                <label class="form-label">Color agenda</label>

                <input type="color"
                       id="color_agenda"
                       class="form-control form-control-color"
                       value="#0d6efd">
              </div>

              <div class="col-md-12">
                <label class="form-label">
                  Días atención
                </label>

                <div class="d-flex flex-wrap gap-3 mt-2">

                  <div class="form-check">
                    <input class="form-check-input dia-agenda"
                           type="checkbox"
                           value="LUN"
                           id="dia_lun">

                    <label class="form-check-label" for="dia_lun">
                      Lunes
                    </label>
                  </div>

                  <div class="form-check">
                    <input class="form-check-input dia-agenda"
                           type="checkbox"
                           value="MAR"
                           id="dia_mar">

                    <label class="form-check-label" for="dia_mar">
                      Martes
                    </label>
                  </div>

                  <div class="form-check">
                    <input class="form-check-input dia-agenda"
                           type="checkbox"
                           value="MIE"
                           id="dia_mie">

                    <label class="form-check-label" for="dia_mie">
                      Miércoles
                    </label>
                  </div>

                  <div class="form-check">
                    <input class="form-check-input dia-agenda"
                           type="checkbox"
                           value="JUE"
                           id="dia_jue">

                    <label class="form-check-label" for="dia_jue">
                      Jueves
                    </label>
                  </div>

                  <div class="form-check">
                    <input class="form-check-input dia-agenda"
                           type="checkbox"
                           value="VIE"
                           id="dia_vie">

                    <label class="form-check-label" for="dia_vie">
                      Viernes
                    </label>
                  </div>

                  <div class="form-check">
                    <input class="form-check-input dia-agenda"
                           type="checkbox"
                           value="SAB"
                           id="dia_sab">

                    <label class="form-check-label" for="dia_sab">
                      Sábado
                    </label>
                  </div>

                </div>

              </div>

            </div>

            <div id="mensajeAgenda"
                 class="alert d-none mt-3">
            </div>

          </div>

          <div class="modal-footer">

            <button class="btn btn-light"
                    data-bs-dismiss="modal">

              Cancelar

            </button>

            <button class="btn btn-primary"
                    onclick="guardarAgenda()">

              <i class="bi bi-save me-1"></i>
              Guardar

            </button>

          </div>

        </div>

      </div>

    </div>
  `;
}

// =========================
// INICIO
// =========================

async function cargarResumenInicio() {
  try {
    const [resIps, resSedes, resServicios] = await Promise.all([
      fetch(`${API_BASE}/ips`, { headers: headersAuth() }),
      fetch(`${API_BASE}/sedes`, { headers: headersAuth() }),
      fetch(`${API_BASE}/servicios`, { headers: headersAuth() })
    ]);

    if (
      validarRespuestaNoAutorizada(resIps) ||
      validarRespuestaNoAutorizada(resSedes) ||
      validarRespuestaNoAutorizada(resServicios)
    ) return;

    const dataIps = await resIps.json();
    const dataSedes = await resSedes.json();
    const dataServicios = await resServicios.json();

    document.getElementById('totalIps').textContent = dataIps.datos ? dataIps.datos.length : 0;
    document.getElementById('totalSedes').textContent = dataSedes.datos ? dataSedes.datos.length : 0;
    document.getElementById('totalServicios').textContent = dataServicios.datos ? dataServicios.datos.length : 0;

  } catch (error) {
    console.error(error);
  }
}

// =========================
// IPS MODULAR
// =========================

async function cargarIps() {

  const tabla = document.getElementById('tablaIps');

  tabla.innerHTML = `
    <div class="text-center p-4">
      Cargando IPS...
    </div>
  `;

  try {

    const data = await listarIpsApi();

    if (!data.ok) {

      tabla.innerHTML = `
        <div class="alert alert-danger">
          ${data.mensaje || 'Error cargando IPS'}
        </div>
      `;

      return;
    }

    tabla.innerHTML = renderTablaIps(data.datos);

  } catch (error) {

    console.error(error);

    tabla.innerHTML = `
      <div class="alert alert-danger">
        Error conectando con backend
      </div>
    `;
  }
}

function abrirModalIps() {

  limpiarFormularioIps();

  document.getElementById('tituloModalIps').textContent =
    'Nueva IPS';

  new bootstrap.Modal(
    document.getElementById('modalIps')
  ).show();
}

function limpiarFormularioIps() {

  document.getElementById('id_ips').value = '';

  document.getElementById('nombre_ips').value = '';

  document.getElementById('razon_social_ips').value = '';

  document.getElementById('nit_ips').value = '';

  document.getElementById('codigo_habilitacion_ips').value = '';

  document.getElementById('direccion_ips').value = '';

  document.getElementById('telefono_ips').value = '';

  document.getElementById('correo_ips').value = '';

  const mensaje = document.getElementById('mensajeIps');

  mensaje.className = 'alert d-none mt-3';

  mensaje.textContent = '';
}

function mostrarMensajeIps(texto, tipo) {

  const mensaje = document.getElementById('mensajeIps');

  mensaje.className = `alert alert-${tipo} mt-3`;

  mensaje.textContent = texto;
}

async function guardarIps() {

  const id = document.getElementById('id_ips').value;

  const datos = {
    nombre: document.getElementById('nombre_ips').value.trim(),
    razon_social: document.getElementById('razon_social_ips').value.trim(),
    nit: document.getElementById('nit_ips').value.trim(),
    codigo_habilitacion: document.getElementById('codigo_habilitacion_ips').value.trim(),
    direccion: document.getElementById('direccion_ips').value.trim(),
    telefono: document.getElementById('telefono_ips').value.trim(),
    correo: document.getElementById('correo_ips').value.trim()
  };

  if (!datos.nombre || !datos.nit) {

    mostrarMensajeIps(
      'Nombre y NIT son obligatorios',
      'danger'
    );

    return;
  }

  try {

    let respuesta;

    if (id) {

      respuesta = await actualizarIpsApi(id, datos);

    } else {

      respuesta = await crearIpsApi(datos);

    }

    if (!respuesta.ok) {

      mostrarMensajeIps(
        respuesta.mensaje || 'Error guardando IPS',
        'danger'
      );

      return;
    }

    mostrarMensajeIps(
      respuesta.mensaje || 'IPS guardada correctamente',
      'success'
    );

    setTimeout(() => {

      bootstrap.Modal
        .getInstance(document.getElementById('modalIps'))
        .hide();

      cargarIps();

    }, 700);

  } catch (error) {

    console.error(error);

    mostrarMensajeIps(
      'Error conectando backend',
      'danger'
    );
  }
}

async function eliminarIpsVista(id) {

  if (!confirm('¿Deseas inactivar esta IPS?')) {
    return;
  }

  try {

    const respuesta = await eliminarIpsApi(id);

    if (!respuesta.ok) {

      alert(
        respuesta.mensaje || 'Error eliminando IPS'
      );

      return;
    }

    cargarIps();

  } catch (error) {

    console.error(error);

    alert('Error conectando backend');
  }
}


// =========================
// SEDES
// =========================

async function cargarSedes() {
  try {
    const res = await fetch(`${API_BASE}/sedes`, { headers: headersAuth() });
    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {
      document.getElementById('tablaSedes').innerHTML = `<div class="alert alert-danger">${data.mensaje || 'Error al cargar sedes'}</div>`;
      return;
    }

    if (!data.datos || data.datos.length === 0) {
      document.getElementById('tablaSedes').innerHTML = `<div class="alert alert-info mb-0">No hay sedes registradas.</div>`;
      return;
    }

    let html = `
      <div class="table-responsive">
        <table class="table table-hover align-middle">
          <thead class="table-light">
            <tr>
              <th>ID</th>
              <th>Sede</th>
              <th>IPS</th>
              <th>Identificador</th>
              <th>FHIR ID</th>
              <th>Estado</th>
              <th class="text-end">Acciones</th>
            </tr>
          </thead>
          <tbody>
    `;

    data.datos.forEach(sede => {
      html += `
        <tr>
          <td>${sede.id_sede}</td>
          <td><strong>${sede.nombre}</strong><br><small class="text-muted">${sede.direccion || ''}</small></td>
          <td>${sede.nombre_ips || sede.ips || ''}</td>
          <td>${sede.identificador || ''}</td>
          <td><span class="badge bg-info">${sede.fhir_id || 'Pendiente'}</span></td>
          <td><span class="badge ${sede.activo ? 'bg-success' : 'bg-secondary'}">${sede.activo ? 'Activo' : 'Inactivo'}</span></td>
          <td class="text-end">
            <button class="btn btn-sm btn-outline-primary" onclick='editarSede(${JSON.stringify(sede)})'><i class="bi bi-pencil"></i></button>
            <button class="btn btn-sm btn-outline-danger" onclick="eliminarSede(${sede.id_sede})"><i class="bi bi-trash"></i></button>
          </td>
        </tr>
      `;
    });

    html += `</tbody></table></div>`;
    document.getElementById('tablaSedes').innerHTML = html;

  } catch (error) {
    console.error(error);
    document.getElementById('tablaSedes').innerHTML = `<div class="alert alert-danger">No fue posible conectar con el backend</div>`;
  }
}

async function abrirModalSede() {
  limpiarFormularioSede();
  document.getElementById('tituloModalSede').textContent = 'Nueva Sede';
  await cargarIpsEnSelect('id_ips_sede');
  new bootstrap.Modal(document.getElementById('modalSede')).show();
}

async function cargarIpsEnSelect(idSelect) {
  const select = document.getElementById(idSelect);
  select.innerHTML = `<option value="">Cargando IPS...</option>`;

  try {
    const res = await fetch(`${API_BASE}/ips`, { headers: headersAuth() });
    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();
    select.innerHTML = `<option value="">Seleccione una IPS</option>`;

    if (!data.datos) return;

    data.datos.filter(ips => ips.activo).forEach(ips => {
      select.innerHTML += `<option value="${ips.id_ips}">${ips.nombre} - ${ips.nit}</option>`;
    });

  } catch (error) {
    console.error(error);
    select.innerHTML = `<option value="">Error cargando IPS</option>`;
  }
}

async function editarSede(sede) {
  limpiarFormularioSede();
  document.getElementById('tituloModalSede').textContent = 'Editar Sede';
  await cargarIpsEnSelect('id_ips_sede');

  document.getElementById('id_sede').value = sede.id_sede;
  document.getElementById('id_ips_sede').value = sede.id_ips;
  document.getElementById('nombre_sede').value = sede.nombre || '';
  document.getElementById('identificador_sede').value = sede.identificador || '';
  document.getElementById('codigo_habilitacion_sede').value = sede.codigo_habilitacion || '';
  document.getElementById('direccion_sede').value = sede.direccion || '';
  document.getElementById('telefono_sede').value = sede.telefono || '';

  new bootstrap.Modal(document.getElementById('modalSede')).show();
}

async function guardarSede() {
  const id = document.getElementById('id_sede').value;

  const datos = {
    id_ips: Number(document.getElementById('id_ips_sede').value),
    nombre: document.getElementById('nombre_sede').value.trim(),
    identificador: document.getElementById('identificador_sede').value.trim(),
    codigo_habilitacion: document.getElementById('codigo_habilitacion_sede').value.trim(),
    direccion: document.getElementById('direccion_sede').value.trim(),
    telefono: document.getElementById('telefono_sede').value.trim()
  };

  if (!datos.id_ips || !datos.nombre || !datos.identificador) {
    mostrarMensajeSede('IPS, nombre e identificador son obligatorios', 'danger');
    return;
  }

  const url = id ? `${API_BASE}/sedes/${id}` : `${API_BASE}/sedes`;
  const metodo = id ? 'PUT' : 'POST';

  try {
    const res = await fetch(url, {
      method: metodo,
      headers: headersAuth(),
      body: JSON.stringify(datos)
    });

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {
      mostrarMensajeSede(data.mensaje || 'Error al guardar sede', 'danger');
      return;
    }

    mostrarMensajeSede(data.mensaje || 'Sede guardada correctamente', 'success');

    setTimeout(() => {
      bootstrap.Modal.getInstance(document.getElementById('modalSede')).hide();
      cargarSedes();
    }, 700);

  } catch (error) {
    console.error(error);
    mostrarMensajeSede('Error de conexión con el backend', 'danger');
  }
}

async function eliminarSede(id) {
  if (!confirm('¿Seguro que deseas inactivar esta sede?')) return;

  try {
    const res = await fetch(`${API_BASE}/sedes/${id}`, {
      method: 'DELETE',
      headers: headersAuth()
    });

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {
      alert(data.mensaje || 'Error al eliminar sede');
      return;
    }

    cargarSedes();

  } catch (error) {
    console.error(error);
    alert('Error de conexión con el backend');
  }
}

function limpiarFormularioSede() {
  const idSede = document.getElementById('id_sede');
  if (!idSede) return;

  document.getElementById('id_sede').value = '';
  document.getElementById('id_ips_sede').innerHTML = '';
  document.getElementById('nombre_sede').value = '';
  document.getElementById('identificador_sede').value = '';
  document.getElementById('codigo_habilitacion_sede').value = '';
  document.getElementById('direccion_sede').value = '';
  document.getElementById('telefono_sede').value = '';

  const mensaje = document.getElementById('mensajeSede');
  mensaje.className = 'alert d-none mt-3';
  mensaje.textContent = '';
}

function mostrarMensajeSede(texto, tipo) {
  const mensaje = document.getElementById('mensajeSede');
  mensaje.className = `alert alert-${tipo} mt-3`;
  mensaje.textContent = texto;
}

// =========================
// SERVICIOS
// =========================

async function cargarServicios() {
  try {
    const res = await fetch(`${API_BASE}/servicios`, { headers: headersAuth() });
    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {
      document.getElementById('tablaServicios').innerHTML = `<div class="alert alert-danger">${data.mensaje || 'Error al cargar servicios'}</div>`;
      return;
    }

    if (!data.datos || data.datos.length === 0) {
      document.getElementById('tablaServicios').innerHTML = `<div class="alert alert-info mb-0">No hay servicios registrados.</div>`;
      return;
    }

    let html = `
      <div class="table-responsive">
        <table class="table table-hover align-middle">
          <thead class="table-light">
            <tr>
              <th>ID</th>
              <th>Servicio</th>
              <th>IPS</th>
              <th>Sede</th>
              <th>Especialidad</th>
              <th>FHIR ID</th>
              <th>Estado</th>
              <th class="text-end">Acciones</th>
            </tr>
          </thead>
          <tbody>
    `;

    data.datos.forEach(servicio => {
      html += `
        <tr>
          <td>${servicio.id_servicio}</td>
          <td><strong>${servicio.nombre}</strong><br><small class="text-muted">${servicio.descripcion || ''}</small></td>
          <td>${servicio.nombre_ips || ''}</td>
          <td>${servicio.nombre_sede || ''}</td>
          <td>${servicio.nombre_especialidad || 'Sin especialidad'}</td>
          <td><span class="badge bg-info">${servicio.fhir_id || 'Pendiente'}</span></td>
          <td><span class="badge ${servicio.activo ? 'bg-success' : 'bg-secondary'}">${servicio.activo ? 'Activo' : 'Inactivo'}</span></td>
          <td class="text-end">
            <button class="btn btn-sm btn-outline-primary" onclick='editarServicio(${JSON.stringify(servicio)})'><i class="bi bi-pencil"></i></button>
            <button class="btn btn-sm btn-outline-danger" onclick="eliminarServicio(${servicio.id_servicio})"><i class="bi bi-trash"></i></button>
          </td>
        </tr>
      `;
    });

    html += `</tbody></table></div>`;
    document.getElementById('tablaServicios').innerHTML = html;

  } catch (error) {
    console.error(error);
    document.getElementById('tablaServicios').innerHTML = `<div class="alert alert-danger">No fue posible conectar con el backend</div>`;
  }
}

async function abrirModalServicio() {
  limpiarFormularioServicio();
  document.getElementById('tituloModalServicio').textContent = 'Nuevo Servicio';

  await cargarIpsEnSelect('id_ips_servicio');
  await cargarEspecialidadesEnSelect();

  document.getElementById('id_ips_servicio').addEventListener('change', cargarSedesServicioPorIps);

  new bootstrap.Modal(document.getElementById('modalServicio')).show();
}

async function cargarSedesServicioPorIps() {
  const idIps = Number(document.getElementById('id_ips_servicio').value);
  const selectSede = document.getElementById('id_sede_servicio');

  // 🔥 LIMPIA SIEMPRE
  selectSede.innerHTML = `<option value="">Seleccione una sede</option>`;

  if (!idIps) return;

  try {
    const res = await fetch(`${API_BASE}/sedes`, { headers: headersAuth() });
    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.datos) return;

    // 🔥 EVITAR DUPLICADOS
    const sedesUnicas = new Map();

    data.datos
      .filter(sede => sede.activo && Number(sede.id_ips) === idIps)
      .forEach(sede => {
        sedesUnicas.set(sede.id_sede, sede);
      });

    sedesUnicas.forEach(sede => {
      selectSede.innerHTML += `
        <option value="${sede.id_sede}">
          ${sede.nombre} - ${sede.identificador || ''}
        </option>
      `;
    });

  } catch (error) {
    console.error(error);
    selectSede.innerHTML = `<option value="">Error cargando sedes</option>`;
  }
}

async function cargarEspecialidadesEnSelect() {
  const select = document.getElementById('id_especialidad_servicio');
  select.innerHTML = `<option value="">Sin especialidad</option>`;

  try {
    const res = await fetch(`${API_BASE}/especialidades`, { headers: headersAuth() });

    if (!res.ok) return;

    const data = await res.json();

    if (!data.datos) return;

    data.datos
      .filter(e => e.activo)
      .forEach(e => {
        select.innerHTML += `<option value="${e.id_especialidad}">${e.nombre}</option>`;
      });

  } catch (error) {
    console.warn('No existe endpoint de especialidades todavía.');
  }
}

async function editarServicio(servicio) {
  limpiarFormularioServicio();
  document.getElementById('tituloModalServicio').textContent = 'Editar Servicio';

  await cargarIpsEnSelect('id_ips_servicio');
  await cargarEspecialidadesEnSelect();

  document.getElementById('id_servicio').value = servicio.id_servicio;
  document.getElementById('id_ips_servicio').value = servicio.id_ips;

  await cargarSedesServicioPorIps();

  document.getElementById('id_sede_servicio').value = servicio.id_sede;
  document.getElementById('id_especialidad_servicio').value = servicio.id_especialidad || '';
  document.getElementById('nombre_servicio').value = servicio.nombre || '';
  document.getElementById('descripcion_servicio').value = servicio.descripcion || '';

  document.getElementById('id_ips_servicio').addEventListener('change', cargarSedesServicioPorIps);

  new bootstrap.Modal(document.getElementById('modalServicio')).show();
}

async function guardarServicio() {
  const id = document.getElementById('id_servicio').value;

  const datos = {
    id_ips: Number(document.getElementById('id_ips_servicio').value),
    id_sede: Number(document.getElementById('id_sede_servicio').value),
    id_especialidad: document.getElementById('id_especialidad_servicio').value
      ? Number(document.getElementById('id_especialidad_servicio').value)
      : null,
    nombre: document.getElementById('nombre_servicio').value.trim(),
    descripcion: document.getElementById('descripcion_servicio').value.trim()
  };

  if (!datos.id_ips || !datos.id_sede || !datos.nombre) {
    mostrarMensajeServicio('IPS, sede y nombre del servicio son obligatorios', 'danger');
    return;
  }

  const url = id ? `${API_BASE}/servicios/${id}` : `${API_BASE}/servicios`;
  const metodo = id ? 'PUT' : 'POST';

  try {
    const res = await fetch(url, {
      method: metodo,
      headers: headersAuth(),
      body: JSON.stringify(datos)
    });

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {
      mostrarMensajeServicio(data.mensaje || 'Error al guardar servicio', 'danger');
      return;
    }

    mostrarMensajeServicio(data.mensaje || 'Servicio guardado correctamente', 'success');

    setTimeout(() => {
      bootstrap.Modal.getInstance(document.getElementById('modalServicio')).hide();
      cargarServicios();
    }, 700);

  } catch (error) {
    console.error(error);
    mostrarMensajeServicio('Error de conexión con el backend', 'danger');
  }
}

async function eliminarServicio(id) {
  if (!confirm('¿Seguro que deseas inactivar este servicio?')) return;

  try {
    const res = await fetch(`${API_BASE}/servicios/${id}`, {
      method: 'DELETE',
      headers: headersAuth()
    });

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {
      alert(data.mensaje || 'Error al eliminar servicio');
      return;
    }

    cargarServicios();

  } catch (error) {
    console.error(error);
    alert('Error de conexión con el backend');
  }
}

function limpiarFormularioServicio() {
  const idServicio = document.getElementById('id_servicio');
  if (!idServicio) return;

  document.getElementById('id_servicio').value = '';
  document.getElementById('id_ips_servicio').innerHTML = '';
  document.getElementById('id_sede_servicio').innerHTML = '<option value="">Seleccione una sede</option>';
  document.getElementById('id_especialidad_servicio').innerHTML = '<option value="">Sin especialidad</option>';
  document.getElementById('nombre_servicio').value = '';
  document.getElementById('descripcion_servicio').value = '';

  const mensaje = document.getElementById('mensajeServicio');
  mensaje.className = 'alert d-none mt-3';
  mensaje.textContent = '';
}

function mostrarMensajeServicio(texto, tipo) {
  const mensaje = document.getElementById('mensajeServicio');
  mensaje.className = `alert alert-${tipo} mt-3`;
  mensaje.textContent = texto;
}

// =========================
// ESPECIALIDADES
// =========================

async function cargarEspecialidades() {
  try {
    const res = await fetch(`${API_BASE}/especialidades`, { headers: headersAuth() });
    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.datos || data.datos.length === 0) {
      document.getElementById('tablaEspecialidades').innerHTML =
        `<div class="alert alert-info">No hay especialidades</div>`;
      return;
    }

    let html = `
      <table class="table table-hover">
        <thead>
          <tr>
            <th>ID</th>
            <th>Código</th>
            <th>Nombre</th>
            <th>Estado</th>
            <th class="text-end">Acciones</th>
          </tr>
        </thead>
        <tbody>
    `;

    data.datos.forEach(e => {
      html += `
        <tr>
          <td>${e.id_especialidad}</td>
          <td>${e.codigo || ''}</td>
          <td><strong>${e.nombre}</strong></td>
          <td>
            <span class="badge ${e.activo ? 'bg-success' : 'bg-secondary'}">
              ${e.activo ? 'Activo' : 'Inactivo'}
            </span>
          </td>
          <td class="text-end">
            <button class="btn btn-sm btn-outline-primary" onclick='editarEspecialidad(${JSON.stringify(e)})'>
              <i class="bi bi-pencil"></i>
            </button>
            <button class="btn btn-sm btn-outline-danger" onclick="eliminarEspecialidad(${e.id_especialidad})">
              <i class="bi bi-trash"></i>
            </button>
          </td>
        </tr>
      `;
    });

    html += `</tbody></table>`;
    document.getElementById('tablaEspecialidades').innerHTML = html;

  } catch (error) {
    console.error(error);
  }
}

function abrirModalEspecialidad() {
  limpiarEspecialidad();
  new bootstrap.Modal(document.getElementById('modalEspecialidad')).show();
}

function editarEspecialidad(e) {
  document.getElementById('id_especialidad').value = e.id_especialidad;
  document.getElementById('codigo_especialidad').value = e.codigo || '';
  document.getElementById('nombre_especialidad').value = e.nombre || '';
  new bootstrap.Modal(document.getElementById('modalEspecialidad')).show();
}

async function guardarEspecialidad() {
  const id = document.getElementById('id_especialidad').value;

  const datos = {
    codigo: document.getElementById('codigo_especialidad').value,
    nombre: document.getElementById('nombre_especialidad').value
  };

  if (!datos.nombre) {
    mostrarMensajeEspecialidad('Nombre obligatorio', 'danger');
    return;
  }

  const url = id ? `${API_BASE}/especialidades/${id}` : `${API_BASE}/especialidades`;
  const metodo = id ? 'PUT' : 'POST';

  const res = await fetch(url, {
    method: metodo,
    headers: headersAuth(),
    body: JSON.stringify(datos)
  });

  const data = await res.json();

  if (!data.ok) {
    mostrarMensajeEspecialidad(data.mensaje, 'danger');
    return;
  }

  mostrarMensajeEspecialidad(data.mensaje, 'success');

  setTimeout(() => {
    bootstrap.Modal.getInstance(document.getElementById('modalEspecialidad')).hide();
    cargarEspecialidades();
  }, 700);
}

async function eliminarEspecialidad(id) {
  if (!confirm('¿Eliminar especialidad?')) return;

  await fetch(`${API_BASE}/especialidades/${id}`, {
    method: 'DELETE',
    headers: headersAuth()
  });

  cargarEspecialidades();
}

function limpiarEspecialidad() {
  document.getElementById('id_especialidad').value = '';
  document.getElementById('codigo_especialidad').value = '';
  document.getElementById('nombre_especialidad').value = '';
}

function mostrarMensajeEspecialidad(texto, tipo) {
  const msg = document.getElementById('mensajeEspecialidad');
  msg.className = `alert alert-${tipo}`;
  msg.textContent = texto;
}

// =========================
// PROFESIONALES
// =========================

async function cargarProfesionales() {
  try {
    const res = await fetch(`${API_BASE}/profesionales`, { headers: headersAuth() });
    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {
      document.getElementById('tablaProfesionales').innerHTML =
        `<div class="alert alert-danger">${data.mensaje || 'Error al cargar profesionales'}</div>`;
      return;
    }

    if (!data.datos || data.datos.length === 0) {
      document.getElementById('tablaProfesionales').innerHTML =
        `<div class="alert alert-info mb-0">No hay profesionales registrados.</div>`;
      return;
    }

    let html = `
      <div class="table-responsive">
        <table class="table table-hover align-middle">
          <thead class="table-light">
            <tr>
              <th>ID</th>
              <th>Profesional</th>
              <th>Documento</th>
              <th>Especialidad</th>
              <th>Tarjeta</th>
              <th>FHIR ID</th>
              <th>Estado</th>
              <th class="text-end">Acciones</th>
            </tr>
          </thead>
          <tbody>
    `;

    data.datos.forEach(p => {
      html += `
        <tr>
          <td>${p.id_profesional}</td>
          <td>
            <strong>${p.nombres || ''} ${p.apellidos || ''}</strong><br>
            <small class="text-muted">${p.correo || ''}</small>
          </td>
          <td>${p.codigo_tipo_documento || ''} ${p.numero_documento || ''}</td>
          <td>${p.nombre_especialidad || 'Sin especialidad'}</td>
          <td>${p.tarjeta_profesional || ''}</td>
          <td><span class="badge bg-info">${p.fhir_id || 'Pendiente'}</span></td>
          <td>
            <span class="badge ${p.activo ? 'bg-success' : 'bg-secondary'}">
              ${p.activo ? 'Activo' : 'Inactivo'}
            </span>
          </td>
          <td class="text-end">
            <button class="btn btn-sm btn-outline-primary" onclick='editarProfesional(${JSON.stringify(p)})'>
              <i class="bi bi-pencil"></i>
            </button>
            <button class="btn btn-sm btn-outline-danger" onclick="eliminarProfesional(${p.id_profesional})">
              <i class="bi bi-trash"></i>
            </button>
          </td>
        </tr>
      `;
    });

    html += `</tbody></table></div>`;

    document.getElementById('tablaProfesionales').innerHTML = html;

  } catch (error) {
    console.error(error);
    document.getElementById('tablaProfesionales').innerHTML =
      `<div class="alert alert-danger">No fue posible conectar con el backend</div>`;
  }
}

async function abrirModalProfesional() {
  limpiarFormularioProfesional();

  document.getElementById('tituloModalProfesional').textContent = 'Nuevo Profesional';

  await cargarTiposDocumentoProfesionalSelect();
  await cargarEspecialidadesProfesionalSelect();
  

  new bootstrap.Modal(document.getElementById('modalProfesional')).show();
}

async function cargarEspecialidadesProfesionalSelect() {
  const select = document.getElementById('id_especialidad_profesional');
  select.innerHTML = `<option value="">Cargando especialidades...</option>`;

  try {
    const res = await fetch(`${API_BASE}/especialidades`, { headers: headersAuth() });
    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    select.innerHTML = `<option value="">Seleccione una especialidad</option>`;

    if (!data.datos) return;

    data.datos
      .filter(e => e.activo)
      .forEach(e => {
        select.innerHTML += `
          <option value="${e.id_especialidad}">
            ${e.nombre}
          </option>
        `;
      });

  } catch (error) {
    console.error(error);
    select.innerHTML = `<option value="">Error cargando especialidades</option>`;
  }
}

async function editarProfesional(p) {
  limpiarFormularioProfesional();

  document.getElementById('tituloModalProfesional').textContent = 'Editar Profesional';

  await cargarTiposDocumentoProfesionalSelect();
  await cargarEspecialidadesProfesionalSelect();

  document.getElementById('id_profesional').value = p.id_profesional;
  document.getElementById('nombres_profesional').value = p.nombres || '';
  document.getElementById('apellidos_profesional').value = p.apellidos || '';
  document.getElementById('id_tipo_documento_profesional').value = p.id_tipo_documento || '';
  document.getElementById('numero_documento_profesional').value = p.numero_documento || '';
  document.getElementById('tarjeta_profesional').value = p.tarjeta_profesional || '';
  document.getElementById('id_especialidad_profesional').value = p.id_especialidad || '';
  document.getElementById('telefono_profesional').value = p.telefono || '';
  document.getElementById('correo_profesional').value = p.correo || '';

  new bootstrap.Modal(document.getElementById('modalProfesional')).show();
}

async function guardarProfesional() {
  const id = document.getElementById('id_profesional').value;

  const datos = {
    id_tipo_documento: document.getElementById('id_tipo_documento_profesional').value.trim(),
    numero_documento: document.getElementById('numero_documento_profesional').value.trim(),
    nombres: document.getElementById('nombres_profesional').value.trim(),
    apellidos: document.getElementById('apellidos_profesional').value.trim(),
    tarjeta_profesional: document.getElementById('tarjeta_profesional').value.trim(),
    id_especialidad: Number(document.getElementById('id_especialidad_profesional').value),
    telefono: document.getElementById('telefono_profesional').value.trim(),
    correo: document.getElementById('correo_profesional').value.trim()
  };

  if (!datos.nombres || !datos.apellidos || !datos.tarjeta_profesional || !datos.id_especialidad) {
    mostrarMensajeProfesional(
      'Nombres, apellidos, tarjeta profesional y especialidad son obligatorios',
      'danger'
    );
    return;
  }

  const url = id ? `${API_BASE}/profesionales/${id}` : `${API_BASE}/profesionales`;
  const metodo = id ? 'PUT' : 'POST';

  try {
    const res = await fetch(url, {
      method: metodo,
      headers: headersAuth(),
      body: JSON.stringify(datos)
    });

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {
      mostrarMensajeProfesional(data.mensaje || 'Error al guardar profesional', 'danger');
      return;
    }

    mostrarMensajeProfesional(data.mensaje || 'Profesional guardado correctamente', 'success');

    setTimeout(() => {
      bootstrap.Modal.getInstance(document.getElementById('modalProfesional')).hide();
      cargarProfesionales();
    }, 700);

  } catch (error) {
    console.error(error);
    mostrarMensajeProfesional('Error de conexión con el backend', 'danger');
  }
}

async function eliminarProfesional(id) {
  if (!confirm('¿Seguro que deseas inactivar este profesional?')) return;

  try {
    const res = await fetch(`${API_BASE}/profesionales/${id}`, {
      method: 'DELETE',
      headers: headersAuth()
    });

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {
      alert(data.mensaje || 'Error al inactivar profesional');
      return;
    }

    cargarProfesionales();

  } catch (error) {
    console.error(error);
    alert('Error de conexión con el backend');
  }
}

function limpiarFormularioProfesional() {
  const idProfesional = document.getElementById('id_profesional');
  if (!idProfesional) return;

  document.getElementById('id_profesional').value = '';
  document.getElementById('nombres_profesional').value = '';
  document.getElementById('apellidos_profesional').value = '';
  document.getElementById('id_tipo_documento_profesional').value = '';
  document.getElementById('numero_documento_profesional').value = '';
  document.getElementById('tarjeta_profesional').value = '';
  document.getElementById('id_especialidad_profesional').innerHTML =
    '<option value="">Seleccione una especialidad</option>';
  document.getElementById('telefono_profesional').value = '';
  document.getElementById('correo_profesional').value = '';

  const mensaje = document.getElementById('mensajeProfesional');
  mensaje.className = 'alert d-none mt-3';
  mensaje.textContent = '';
}

function mostrarMensajeProfesional(texto, tipo) {
  const mensaje = document.getElementById('mensajeProfesional');
  mensaje.className = `alert alert-${tipo} mt-3`;
  mensaje.textContent = texto;
}

async function cargarTiposDocumentoProfesionalSelect() {
  const select = document.getElementById('id_tipo_documento_profesional');
  select.innerHTML = `<option value="">Cargando tipos...</option>`;

  try {
    const res = await fetch(`${API_BASE}/tipos-documento`, { headers: headersAuth() });
    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    select.innerHTML = `<option value="">Seleccione un tipo</option>`;

    if (!data.datos) return;

    data.datos.forEach(t => {
      select.innerHTML += `
        <option value="${t.id_tipo_documento}">
          ${t.codigo} - ${t.descripcion}
        </option>
      `;
    });

  } catch (error) {
    console.error(error);
    select.innerHTML = `<option value="">Error cargando tipos</option>`;
  }
}


// =========================
// ROLES PROFESIONAL
// =========================

async function cargarRolesProfesional() {

  try {

    const res = await fetch(
      `${API_BASE}/roles-profesional`,
      {
        headers: headersAuth()
      }
    );

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {
      document.getElementById('tablaRolesProfesional').innerHTML =
        `<div class="alert alert-danger">${data.mensaje}</div>`;
      return;
    }

    if (!data.datos || data.datos.length === 0) {

      document.getElementById('tablaRolesProfesional').innerHTML =
        `<div class="alert alert-info mb-0">No hay asignaciones registradas.</div>`;

      return;
    }

    let html = `
      <div class="table-responsive">

        <table class="table table-hover align-middle">

          <thead class="table-light">

            <tr>
              <th>ID</th>
              <th>Profesional</th>
              <th>IPS</th>
              <th>Sede</th>
              <th>Servicio</th>
              <th>Jornada</th>
              <th>FHIR</th>
              <th>Estado</th>
              <th class="text-end">Acciones</th>
            </tr>

          </thead>

          <tbody>
    `;

    data.datos.forEach(r => {

      html += `
        <tr>

          <td>${r.id_rol_profesional}</td>

          <td>
            <strong>${r.nombres} ${r.apellidos}</strong>
          </td>

          <td>${r.nombre_ips}</td>

          <td>${r.nombre_sede}</td>

          <td>${r.nombre_servicio}</td>

          <td>${r.jornada || ''}</td>

          <td>
            <span class="badge bg-info">
              ${r.fhir_id || 'Pendiente'}
            </span>
          </td>

          <td>
            <span class="badge ${r.activo ? 'bg-success' : 'bg-secondary'}">
              ${r.activo ? 'Activo' : 'Inactivo'}
            </span>
          </td>

          <td class="text-end">

            <button
              class="btn btn-sm btn-outline-primary"
              onclick='editarRolProfesional(${JSON.stringify(r)})'>

              <i class="bi bi-pencil"></i>

            </button>

            <button
              class="btn btn-sm btn-outline-danger"
              onclick="eliminarRolProfesional(${r.id_rol_profesional})">

              <i class="bi bi-trash"></i>

            </button>

          </td>

        </tr>
      `;
    });

    html += `
          </tbody>
        </table>
      </div>
    `;

    document.getElementById('tablaRolesProfesional').innerHTML = html;

  } catch (error) {

    console.error(error);

    document.getElementById('tablaRolesProfesional').innerHTML =
      `<div class="alert alert-danger">Error conectando backend</div>`;
  }
}

async function abrirModalRolProfesional() {
  limpiarFormularioRolProfesional();

  document.getElementById('tituloModalRolProfesional').textContent =
    'Nueva Asignación Profesional';

  await cargarProfesionalesRolSelect();
  await cargarIpsRolSelect();

  new bootstrap.Modal(document.getElementById('modalRolProfesional')).show();
}

async function cargarProfesionalesRolSelect() {
  const select = document.getElementById('id_profesional_rol');
  select.innerHTML = `<option value="">Cargando profesionales...</option>`;

  try {
    const res = await fetch(`${API_BASE}/profesionales`, { headers: headersAuth() });
    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    select.innerHTML = `<option value="">Seleccione un profesional</option>`;

    if (!data.datos) return;

    data.datos
      .filter(p => p.activo)
      .forEach(p => {
        select.innerHTML += `
          <option value="${p.id_profesional}">
            ${p.nombres} ${p.apellidos} - ${p.nombre_especialidad || 'Sin especialidad'}
          </option>
        `;
      });

  } catch (error) {
    console.error(error);
    select.innerHTML = `<option value="">Error cargando profesionales</option>`;
  }
}

async function cargarIpsRolSelect() {
  const select = document.getElementById('id_ips_rol');
  select.innerHTML = `<option value="">Cargando IPS...</option>`;

  try {
    const res = await fetch(`${API_BASE}/ips`, { headers: headersAuth() });
    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    select.innerHTML = `<option value="">Seleccione una IPS</option>`;

    if (!data.datos) return;

    data.datos
      .filter(i => i.activo)
      .forEach(i => {
        select.innerHTML += `
          <option value="${i.id_ips}">
            ${i.nombre}
          </option>
        `;
      });

  } catch (error) {
    console.error(error);
    select.innerHTML = `<option value="">Error cargando IPS</option>`;
  }
}

async function cargarSedesRolProfesional() {
  const idIps = Number(document.getElementById('id_ips_rol').value);
  const select = document.getElementById('id_sede_rol');

  select.innerHTML = `<option value="">Seleccione una sede</option>`;
  document.getElementById('id_servicio_rol').innerHTML =
    `<option value="">Seleccione un servicio</option>`;

  if (!idIps) return;

  try {
    const res = await fetch(`${API_BASE}/sedes`, { headers: headersAuth() });
    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.datos) return;

    data.datos
      .filter(s => s.activo && Number(s.id_ips) === idIps)
      .forEach(s => {
        select.innerHTML += `
          <option value="${s.id_sede}">
            ${s.nombre}
          </option>
        `;
      });

  } catch (error) {
    console.error(error);
    select.innerHTML = `<option value="">Error cargando sedes</option>`;
  }
}

async function cargarServiciosRolProfesional() {
  const idIps = Number(document.getElementById('id_ips_rol').value);
  const idSede = Number(document.getElementById('id_sede_rol').value);
  const select = document.getElementById('id_servicio_rol');

  select.innerHTML = `<option value="">Seleccione un servicio</option>`;

  if (!idIps || !idSede) return;

  try {
    const res = await fetch(`${API_BASE}/servicios`, { headers: headersAuth() });
    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.datos) return;

    data.datos
      .filter(s =>
        s.activo &&
        Number(s.id_ips) === idIps &&
        Number(s.id_sede) === idSede
      )
      .forEach(s => {
        select.innerHTML += `
          <option value="${s.id_servicio}">
            ${s.nombre}
          </option>
        `;
      });

  } catch (error) {
    console.error(error);
    select.innerHTML = `<option value="">Error cargando servicios</option>`;
  }
}

async function editarRolProfesional(r) {
  limpiarFormularioRolProfesional();

  document.getElementById('tituloModalRolProfesional').textContent =
    'Editar Asignación Profesional';

  await cargarProfesionalesRolSelect();
  await cargarIpsRolSelect();

  document.getElementById('id_rol_profesional').value = r.id_rol_profesional;
  document.getElementById('id_profesional_rol').value = r.id_profesional;
  document.getElementById('id_ips_rol').value = r.id_ips;

  await cargarSedesRolProfesional();

  document.getElementById('id_sede_rol').value = r.id_sede;

  await cargarServiciosRolProfesional();

  document.getElementById('id_servicio_rol').value = r.id_servicio;
  document.getElementById('fecha_inicio_rol').value = r.fecha_inicio
    ? r.fecha_inicio.substring(0, 10)
    : '';
  document.getElementById('fecha_fin_rol').value = r.fecha_fin
    ? r.fecha_fin.substring(0, 10)
    : '';
  document.getElementById('jornada_rol').value = r.jornada || '';

  new bootstrap.Modal(document.getElementById('modalRolProfesional')).show();
}

async function guardarRolProfesional() {
  const id = document.getElementById('id_rol_profesional').value;

  const datos = {
    id_profesional: Number(document.getElementById('id_profesional_rol').value),
    id_ips: Number(document.getElementById('id_ips_rol').value),
    id_sede: Number(document.getElementById('id_sede_rol').value),
    id_servicio: Number(document.getElementById('id_servicio_rol').value),
    fecha_inicio: document.getElementById('fecha_inicio_rol').value,
    fecha_fin: document.getElementById('fecha_fin_rol').value || null,
    jornada: document.getElementById('jornada_rol').value.trim()
  };

  if (
    !datos.id_profesional ||
    !datos.id_ips ||
    !datos.id_sede ||
    !datos.id_servicio ||
    !datos.fecha_inicio
  ) {
    mostrarMensajeRolProfesional(
      'Profesional, IPS, sede, servicio y fecha inicio son obligatorios',
      'danger'
    );
    return;
  }

  const url = id
    ? `${API_BASE}/roles-profesional/${id}`
    : `${API_BASE}/roles-profesional`;

  const metodo = id ? 'PUT' : 'POST';

  try {
    const res = await fetch(url, {
      method: metodo,
      headers: headersAuth(),
      body: JSON.stringify(datos)
    });

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {
  console.error('Error backend rol profesional:', data);

  mostrarMensajeRolProfesional(
    `${data.mensaje || 'Error al guardar asignación'}${data.error ? ': ' + data.error : ''}`,
    'danger'
  );

  return;
}

    mostrarMensajeRolProfesional(
      data.mensaje || 'Asignación guardada correctamente',
      'success'
    );

    setTimeout(() => {
      bootstrap.Modal.getInstance(
        document.getElementById('modalRolProfesional')
      ).hide();

      cargarRolesProfesional();
    }, 700);

  } catch (error) {
    console.error(error);
    mostrarMensajeRolProfesional('Error de conexión con backend', 'danger');
  }
}

async function eliminarRolProfesional(id) {
  if (!confirm('¿Seguro que deseas inactivar esta asignación profesional?')) return;

  try {
    const res = await fetch(`${API_BASE}/roles-profesional/${id}`, {
      method: 'DELETE',
      headers: headersAuth()
    });

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {
      alert(data.mensaje || 'Error al inactivar asignación');
      return;
    }

    cargarRolesProfesional();

  } catch (error) {
    console.error(error);
    alert('Error de conexión con backend');
  }
}

function limpiarFormularioRolProfesional() {
  const idRol = document.getElementById('id_rol_profesional');
  if (!idRol) return;

  document.getElementById('id_rol_profesional').value = '';
  document.getElementById('id_profesional_rol').innerHTML =
    `<option value="">Seleccione un profesional</option>`;
  document.getElementById('id_ips_rol').innerHTML =
    `<option value="">Seleccione una IPS</option>`;
  document.getElementById('id_sede_rol').innerHTML =
    `<option value="">Seleccione una sede</option>`;
  document.getElementById('id_servicio_rol').innerHTML =
    `<option value="">Seleccione un servicio</option>`;
  document.getElementById('fecha_inicio_rol').value = '';
  document.getElementById('fecha_fin_rol').value = '';
  document.getElementById('jornada_rol').value = '';

  const mensaje = document.getElementById('mensajeRolProfesional');
  mensaje.className = 'alert d-none mt-3';
  mensaje.textContent = '';
}

function mostrarMensajeRolProfesional(texto, tipo) {
  const mensaje = document.getElementById('mensajeRolProfesional');
  mensaje.className = `alert alert-${tipo} mt-3`;
  mensaje.textContent = texto;
}

// =========================
// AGENDAS
// =========================

async function cargarAgendas() {

  try {

    const res = await fetch(
      `${API_BASE}/agendas`,
      {
        headers: headersAuth()
      }
    );

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {

      document.getElementById('tablaAgendas').innerHTML =
        `<div class="alert alert-danger">${data.mensaje}</div>`;

      return;
    }

    if (!data.datos || data.datos.length === 0) {

      document.getElementById('tablaAgendas').innerHTML =
        `<div class="alert alert-info mb-0">No hay agendas registradas.</div>`;

      return;
    }

    let html = `
      <div class="table-responsive">

        <table class="table table-hover align-middle">

          <thead class="table-light">

            <tr>
              <th>ID</th>
              <th>Profesional</th>
              <th>Servicio</th>
              <th>Periodo</th>
              <th>Horario</th>
              <th>Días</th>
              <th>Duración</th>
              <th>FHIR</th>
              <th>Estado</th>
              <th class="text-end">Acciones</th>
            </tr>

          </thead>

          <tbody>
    `;

    data.datos.forEach(a => {

      html += `
        <tr>

          <td>${a.id_agenda}</td>

          <td>
            <strong>${a.nombres} ${a.apellidos}</strong><br>
            <small class="text-muted">${a.nombre_sede}</small>
          </td>

          <td>${a.nombre_servicio}</td>

          <td>
            ${a.fecha_inicio?.substring(0,10)}<br>
            <small class="text-muted">
              ${a.fecha_fin?.substring(0,10)}
            </small>
          </td>

          <td>
            ${a.hora_inicio || ''} - ${a.hora_fin || ''}
          </td>

          <td>${a.dias_semana || ''}</td>

          <td>
            ${a.duracion_cupo_minutos || 20} min
          </td>

          <td>
            <span class="badge bg-info">
              ${a.fhir_id || 'Pendiente'}
            </span>
          </td>

          <td>
            <span class="badge ${a.activo ? 'bg-success' : 'bg-secondary'}">
              ${a.activo ? 'Activo' : 'Inactivo'}
            </span>
          </td>

          <td class="text-end">

            <button
              class="btn btn-sm btn-outline-primary"
              onclick='editarAgenda(${JSON.stringify(a)})'>

              <i class="bi bi-pencil"></i>

            </button>

            <button
              class="btn btn-sm btn-outline-danger"
              onclick="eliminarAgenda(${a.id_agenda})">

              <i class="bi bi-trash"></i>

            </button>

          </td>

        </tr>
      `;
    });

    html += `
          </tbody>
        </table>
      </div>
    `;

    document.getElementById('tablaAgendas').innerHTML = html;

  } catch (error) {

    console.error(error);

    document.getElementById('tablaAgendas').innerHTML =
      `<div class="alert alert-danger">Error conectando backend</div>`;
  }
}

async function abrirModalAgenda() {

  limpiarFormularioAgenda();

  document.getElementById('tituloModalAgenda').textContent =
    'Nueva Agenda';

  await cargarIpsAgendaCascada();

  new bootstrap.Modal(
    document.getElementById('modalAgenda')
  ).show();
}

let rolesProfesionalAgendaCache = [];

async function cargarRolesProfesionalAgendaCache() {
  try {
    const res = await fetch(`${API_BASE}/roles-profesional`, {
      headers: headersAuth()
    });

    if (validarRespuestaNoAutorizada(res)) return [];

    const data = await res.json();

    rolesProfesionalAgendaCache = data.datos || [];

    return rolesProfesionalAgendaCache;

  } catch (error) {
    console.error(error);
    rolesProfesionalAgendaCache = [];
    return [];
  }
}

async function cargarIpsAgendaCascada() {
  const select = document.getElementById('id_ips_agenda');

  select.innerHTML = `<option value="">Cargando IPS...</option>`;

  await cargarRolesProfesionalAgendaCache();

  const ipsMap = new Map();

  rolesProfesionalAgendaCache
    .filter(r => r.activo)
    .forEach(r => {
      ipsMap.set(r.id_ips, r.nombre_ips);
    });

  select.innerHTML = `<option value="">Seleccione IPS</option>`;

  ipsMap.forEach((nombre, id) => {
    select.innerHTML += `
      <option value="${id}">
        ${nombre}
      </option>
    `;
  });

  document.getElementById('id_sede_agenda').innerHTML =
    `<option value="">Seleccione sede</option>`;

  document.getElementById('id_servicio_agenda').innerHTML =
    `<option value="">Seleccione servicio</option>`;

  document.getElementById('id_profesional_agenda').innerHTML =
    `<option value="">Seleccione profesional</option>`;

  document.getElementById('id_rol_profesional_agenda').value = '';
}

function cargarSedesAgendaCascada() {
  const idIps = Number(document.getElementById('id_ips_agenda').value);
  const select = document.getElementById('id_sede_agenda');

  select.innerHTML = `<option value="">Seleccione sede</option>`;

  document.getElementById('id_servicio_agenda').innerHTML =
    `<option value="">Seleccione servicio</option>`;

  document.getElementById('id_profesional_agenda').innerHTML =
    `<option value="">Seleccione profesional</option>`;

  document.getElementById('id_rol_profesional_agenda').value = '';

  if (!idIps) return;

  const sedesMap = new Map();

  rolesProfesionalAgendaCache
    .filter(r => r.activo && Number(r.id_ips) === idIps)
    .forEach(r => {
      sedesMap.set(r.id_sede, r.nombre_sede);
    });

  sedesMap.forEach((nombre, id) => {
    select.innerHTML += `
      <option value="${id}">
        ${nombre}
      </option>
    `;
  });
}

function cargarServiciosAgendaCascada() {
  const idIps = Number(document.getElementById('id_ips_agenda').value);
  const idSede = Number(document.getElementById('id_sede_agenda').value);
  const select = document.getElementById('id_servicio_agenda');

  select.innerHTML = `<option value="">Seleccione servicio</option>`;

  document.getElementById('id_profesional_agenda').innerHTML =
    `<option value="">Seleccione profesional</option>`;

  document.getElementById('id_rol_profesional_agenda').value = '';

  if (!idIps || !idSede) return;

  const serviciosMap = new Map();

  rolesProfesionalAgendaCache
    .filter(r =>
      r.activo &&
      Number(r.id_ips) === idIps &&
      Number(r.id_sede) === idSede
    )
    .forEach(r => {
      serviciosMap.set(r.id_servicio, r.nombre_servicio);
    });

  serviciosMap.forEach((nombre, id) => {
    select.innerHTML += `
      <option value="${id}">
        ${nombre}
      </option>
    `;
  });
}

function cargarProfesionalesAgendaCascada() {
  const idIps = Number(document.getElementById('id_ips_agenda').value);
  const idSede = Number(document.getElementById('id_sede_agenda').value);
  const idServicio = Number(document.getElementById('id_servicio_agenda').value);
  const select = document.getElementById('id_profesional_agenda');

  select.innerHTML = `<option value="">Seleccione profesional</option>`;

  document.getElementById('id_rol_profesional_agenda').value = '';

  if (!idIps || !idSede || !idServicio) return;

  rolesProfesionalAgendaCache
    .filter(r =>
      r.activo &&
      Number(r.id_ips) === idIps &&
      Number(r.id_sede) === idSede &&
      Number(r.id_servicio) === idServicio
    )
    .forEach(r => {
      select.innerHTML += `
        <option value="${r.id_profesional}"
                data-rol="${r.id_rol_profesional}">
          ${r.nombres} ${r.apellidos}
        </option>
      `;
    });
}

function resolverRolProfesionalAgenda() {
  const select = document.getElementById('id_profesional_agenda');
  const option = select.options[select.selectedIndex];

  document.getElementById('id_rol_profesional_agenda').value =
    option?.dataset?.rol || '';
}

async function cargarRolesProfesionalAgendaSelect() {

  const select = document.getElementById('id_rol_profesional_agenda');

  select.innerHTML =
    `<option value="">Cargando asignaciones...</option>`;

  try {

    const res = await fetch(
      `${API_BASE}/roles-profesional`,
      {
        headers: headersAuth()
      }
    );

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    select.innerHTML =
      `<option value="">Seleccione una asignación</option>`;

    if (!data.datos) return;

    data.datos
      .filter(r => r.activo)
      .forEach(r => {

        select.innerHTML += `
          <option value="${r.id_rol_profesional}">
            ${r.nombres} ${r.apellidos}
            | ${r.nombre_servicio}
            | ${r.nombre_sede}
          </option>
        `;
      });

  } catch (error) {

    console.error(error);

    select.innerHTML =
      `<option value="">Error cargando asignaciones</option>`;
  }
}

function obtenerDiasAgendaSeleccionados() {

  return Array.from(
    document.querySelectorAll('.dia-agenda:checked')
  )
  .map(d => d.value)
  .join(',');
}

function marcarDiasAgenda(dias) {

  document.querySelectorAll('.dia-agenda')
    .forEach(chk => chk.checked = false);

  if (!dias) return;

  dias.split(',')
    .forEach(dia => {

      const checkbox = document.querySelector(
        `.dia-agenda[value="${dia}"]`
      );

      if (checkbox) {
        checkbox.checked = true;
      }
    });
}

async function editarAgenda(a) {

  limpiarFormularioAgenda();

  document.getElementById('tituloModalAgenda').textContent =
    'Editar Agenda';

  await cargarIpsAgendaCascada();

  const rol = rolesProfesionalAgendaCache.find(
    r => Number(r.id_rol_profesional) === Number(a.id_rol_profesional)
  );

  if (rol) {
    document.getElementById('id_ips_agenda').value = rol.id_ips;

    cargarSedesAgendaCascada();

    document.getElementById('id_sede_agenda').value = rol.id_sede;

    cargarServiciosAgendaCascada();

    document.getElementById('id_servicio_agenda').value = rol.id_servicio;

    cargarProfesionalesAgendaCascada();

    document.getElementById('id_profesional_agenda').value = rol.id_profesional;
    document.getElementById('id_rol_profesional_agenda').value = rol.id_rol_profesional;
  }

  document.getElementById('id_agenda').value = a.id_agenda;

  document.getElementById('fecha_inicio_agenda').value =
    a.fecha_inicio ? a.fecha_inicio.substring(0, 10) : '';

  document.getElementById('fecha_fin_agenda').value =
    a.fecha_fin ? a.fecha_fin.substring(0, 10) : '';

  document.getElementById('hora_inicio_agenda').value =
    a.hora_inicio || '';

  document.getElementById('hora_fin_agenda').value =
    a.hora_fin || '';

  document.getElementById('duracion_cupo_agenda').value =
    a.duracion_cupo_minutos || 20;

  document.getElementById('color_agenda').value =
    a.color_agenda || '#0d6efd';

  marcarDiasAgenda(a.dias_semana);

  new bootstrap.Modal(
    document.getElementById('modalAgenda')
  ).show();
}

async function guardarAgenda() {
	
  if (window.guardandoAgenda) return;
  window.guardandoAgenda = true;
  
  

  const id = document.getElementById('id_agenda').value;
  
  
  const datos = {
  id_ips: Number(document.getElementById('id_ips_agenda').value),
  id_sede: Number(document.getElementById('id_sede_agenda').value),
  id_servicio: Number(document.getElementById('id_servicio_agenda').value),
  id_profesional: Number(document.getElementById('id_profesional_agenda').value),
  id_rol_profesional: Number(document.getElementById('id_rol_profesional_agenda').value),
  fecha_inicio: document.getElementById('fecha_inicio_agenda').value,
  fecha_fin: document.getElementById('fecha_fin_agenda').value,
  hora_inicio: document.getElementById('hora_inicio_agenda').value,
  hora_fin: document.getElementById('hora_fin_agenda').value,
  duracion_cupo_minutos: Number(document.getElementById('duracion_cupo_agenda').value),
  dias_semana: obtenerDiasAgendaSeleccionados(),
  color_agenda: document.getElementById('color_agenda').value
  };

  if (
    !datos.id_rol_profesional ||
    !datos.fecha_inicio ||
    !datos.fecha_fin ||
    !datos.hora_inicio ||
    !datos.hora_fin ||
    !datos.dias_semana
  ) {

    mostrarMensajeAgenda(
	  'Seleccione IPS, sede, servicio, profesional y complete los datos obligatorios',
	  'danger'
	);

    return;
  }

  const url = id
    ? `${API_BASE}/agendas/${id}`
    : `${API_BASE}/agendas`;

  const metodo = id ? 'PUT' : 'POST';
  

  try {

    const res = await fetch(
      url,
      {
        method: metodo,
        headers: headersAuth(),
        body: JSON.stringify(datos)
      }
    );

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {

      mostrarMensajeAgenda(
        `${data.mensaje || 'Error al guardar agenda'}${
          data.error ? ': ' + JSON.stringify(data.error) : ''
        }`,
        'danger'
      );

      return;
    }

    mostrarMensajeAgenda(
      data.mensaje || 'Agenda guardada correctamente',
      'success'
    );

    setTimeout(() => {

      bootstrap.Modal.getInstance(
        document.getElementById('modalAgenda')
      ).hide();

      cargarAgendas();

    }, 700);

  } catch (error) {
    console.error(error);
    mostrarMensajeAgenda('Error de conexión con backend', 'danger');
  } finally {
    window.guardandoAgenda = false;
  }
}

async function eliminarAgenda(id) {

  if (!confirm('¿Seguro que deseas inactivar esta agenda?')) {
    return;
  }

  try {

    const res = await fetch(
      `${API_BASE}/agendas/${id}`,
      {
        method: 'DELETE',
        headers: headersAuth()
      }
    );

    if (validarRespuestaNoAutorizada(res)) return;

    const data = await res.json();

    if (!data.ok) {

      alert(
        data.mensaje || 'Error al inactivar agenda'
      );

      return;
    }

    cargarAgendas();

  } catch (error) {

    console.error(error);

    alert('Error de conexión con backend');
  }
}

function limpiarFormularioAgenda() {

  const idAgenda =
    document.getElementById('id_agenda');

  if (!idAgenda) return;

  document.getElementById('id_agenda').value = '';

  document.getElementById('id_rol_profesional_agenda').value = '';

  document.getElementById('id_ips_agenda').innerHTML =
    `<option value="">Seleccione IPS</option>`;

  document.getElementById('id_sede_agenda').innerHTML =
    `<option value="">Seleccione sede</option>`;

  document.getElementById('id_servicio_agenda').innerHTML =
    `<option value="">Seleccione servicio</option>`;

  document.getElementById('id_profesional_agenda').innerHTML =
    `<option value="">Seleccione profesional</option>`;

  document.getElementById('fecha_inicio_agenda').value = '';
  document.getElementById('fecha_fin_agenda').value = '';
  document.getElementById('hora_inicio_agenda').value = '';
  document.getElementById('hora_fin_agenda').value = '';
  document.getElementById('duracion_cupo_agenda').value = 20;
  document.getElementById('color_agenda').value = '#0d6efd';

  document.querySelectorAll('.dia-agenda')
    .forEach(chk => chk.checked = false);

  const mensaje =
    document.getElementById('mensajeAgenda');

  mensaje.className = 'alert d-none mt-3';
  mensaje.textContent = '';
}

function mostrarMensajeAgenda(texto, tipo) {

  const mensaje =
    document.getElementById('mensajeAgenda');

  mensaje.className =
    `alert alert-${tipo} mt-3`;

  mensaje.textContent = texto;
}

// =========================
// LOGOUT
// =========================

function logout() {
  localStorage.removeItem('usuarioSesion');
  localStorage.removeItem('token');
  window.location.href = 'index.html';
}

cargarVista('inicio');