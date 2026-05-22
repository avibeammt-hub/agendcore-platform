let listaSedes = [];
let modalSede = null;
let editandoSede = null;

/* =========================================================
   CARGAR SEDES
========================================================= */

async function cargarSedes() {

  try {

    mostrarLoader('Cargando sedes...');

    const respuesta =
      await listarSedesApi();

    listaSedes =
      respuesta.datos || [];

    renderModuloSedes(listaSedes);

    ocultarLoader();

  } catch(error){

    console.error(error);

    ocultarLoader();

    mostrarToast(
      'Error al cargar sedes',
      'danger'
    );
  }
}

/* =========================================================
   RENDER
========================================================= */

function renderModuloSedes(datos){

  const contenido =
    document.getElementById('contenido');

  document.getElementById(
    'tituloVista'
  ).textContent = 'Sedes';

  document.getElementById(
    'subtituloVista'
  ).textContent =
    'Gestión interoperable de sedes';

  contenido.innerHTML = `

    <div class="d-flex justify-content-between align-items-center mb-4">

      <div>

        <h2 class="fw-bold mb-1">
          Gestión de Sedes
        </h2>

        <p class="text-muted">
          Administración de sedes sincronizadas con FHIR
        </p>

      </div>

      <button
        class="btn btn-primary btn-lg"
        onclick="abrirModalNuevaSede()">

        <i class="bi bi-plus-circle"></i>
        Nueva Sede

      </button>

    </div>

    <div class="row mb-4 g-3">

      <div class="col-md-4">

        <div class="kpi-card">

          <div>
            <span class="kpi-label">
              SEDES ACTIVAS
            </span>

            <h2>${datos.length}</h2>
          </div>

          <div class="kpi-icon">
            <i class="bi bi-building"></i>
          </div>

        </div>

      </div>

      <div class="col-md-4">

        <div class="kpi-card">

          <div>
            <span class="kpi-label">
              FHIR SYNC
            </span>

            <h2>
              ${datos.filter(
                x => x.fhir_id
              ).length}
            </h2>
          </div>

          <div class="kpi-icon success">
            <i class="bi bi-cloud-check"></i>
          </div>

        </div>

      </div>

      <div class="col-md-4">

        <div class="kpi-card">

          <div>
            <span class="kpi-label">
              ESTADO
            </span>

            <h2>ONLINE</h2>
          </div>

          <div class="kpi-icon warning">
            <i class="bi bi-activity"></i>
          </div>

        </div>

      </div>

    </div>

    <div class="table-card">

      <div class="table-responsive">

        <table class="table table-hover align-middle">

          <thead>

            <tr>
              <th>Sede</th>
              <th>Identificador</th>
              <th>Código</th>
              <th>FHIR</th>
              <th>Estado</th>
              <th class="text-end">
                Acciones
              </th>
            </tr>

          </thead>

          <tbody>

            ${
              datos.map(sede => `

                <tr>

                  <td>
                    <strong>
                      ${sede.nombre || ''}
                    </strong>
                  </td>

                  <td>
                    ${sede.identificador || ''}
                  </td>

                  <td>
                    ${sede.codigo_habilitacion || ''}
                  </td>

                  <td>

                    ${
                      sede.fhir_id
                      ? `
                        <span class="badge bg-success">
                          Sincronizado
                        </span>
                      `
                      : `
                        <span class="badge bg-warning text-dark">
                          Pendiente
                        </span>
                      `
                    }

                  </td>

                  <td>

                    ${
                      sede.activo
                      ? `
                        <span class="badge bg-success">
                          Activa
                        </span>
                      `
                      : `
                        <span class="badge bg-danger">
                          Inactiva
                        </span>
                      `
                    }

                  </td>

                  <td class="text-end">

                    <button
                      class="btn-action edit"
                      onclick="editarSede(${sede.id_sede})">

                      <i class="bi bi-pencil-square"></i>

                    </button>

                    <button
                      class="btn-action delete"
                      onclick="eliminarSedeVista(${sede.id_sede})">

                      <i class="bi bi-trash"></i>

                    </button>

                  </td>

                </tr>

              `).join('')
            }

          </tbody>

        </table>

      </div>

    </div>
  `;
}

/* =========================================================
   MODAL NUEVA SEDE
========================================================= */

function abrirModalNuevaSede(){

  editandoSede = null;

  document.getElementById(
    'formSede'
  ).reset();

  document.querySelector(
    '#modalSede .modal-title'
  ).textContent = 'Nueva Sede';

  modalSede =
    new bootstrap.Modal(
      document.getElementById(
        'modalSede'
      )
    );

  modalSede.show();
}

window.cargarSedes = cargarSedes;
window.abrirModalNuevaSede =
  abrirModalNuevaSede;
  
/* =========================================================
   GUARDAR SEDE
========================================================= */

async function guardarSede(){

  try {

    const datos = {

      nombre:
        document.getElementById(
          'nombreSede'
        ).value,

      identificador:
        document.getElementById(
          'identificadorSede'
        ).value,

      codigo_habilitacion:
        document.getElementById(
          'codigoHabilitacionSede'
        ).value,

      telefono:
        document.getElementById(
          'telefonoSede'
        ).value,

      direccion:
        document.getElementById(
          'direccionSede'
        ).value,

      id_ips: 1
    };

    if (!datos.nombre){

      mostrarToast(
        'Ingrese nombre sede',
        'warning'
      );

      return;
    }

    mostrarLoader(
      'Guardando sede...'
    );

    let respuesta;

    if (editandoSede){

      respuesta =
        await actualizarSedeApi(
          editandoSede,
          datos
        );

    } else {

      respuesta =
        await crearSedeApi(
          datos
        );
    }

    ocultarLoader();

    if (!respuesta.ok){

      mostrarToast(
        respuesta.mensaje ||
        'No fue posible guardar sede',
        'danger'
      );

      return;
    }

    modalSede.hide();

    mostrarToast(
      respuesta.mensaje ||
      'Sede guardada correctamente',
      'success'
    );

    await cargarSedes();

  } catch(error){

    console.error(error);

    ocultarLoader();

    mostrarToast(
      'Error al guardar sede',
      'danger'
    );
  }
}

window.guardarSede =
  guardarSede;
  
  /* =========================================================
   EDITAR SEDE
========================================================= */

function editarSede(id){

  const sede =
    listaSedes.find(
      x => x.id_sede == id
    );

  if (!sede){

    mostrarToast(
      'Sede no encontrada',
      'danger'
    );

    return;
  }

  editandoSede = id;

  document.querySelector(
    '#modalSede .modal-title'
  ).textContent =
    'Editar Sede';

  document.getElementById(
    'nombreSede'
  ).value =
    sede.nombre || '';

  document.getElementById(
    'identificadorSede'
  ).value =
    sede.identificador || '';

  document.getElementById(
    'codigoHabilitacionSede'
  ).value =
    sede.codigo_habilitacion || '';

  document.getElementById(
    'telefonoSede'
  ).value =
    sede.telefono || '';

  document.getElementById(
    'direccionSede'
  ).value =
    sede.direccion || '';

  modalSede =
    new bootstrap.Modal(
      document.getElementById(
        'modalSede'
      )
    );

  modalSede.show();
}

window.editarSede =
  editarSede;
  
  /* =========================================================
   ELIMINAR SEDE
========================================================= */

let sedeEliminar = null;
let modalEliminarSede = null;

function eliminarSedeVista(id){

  sedeEliminar = id;

  modalEliminarSede =
    new bootstrap.Modal(
      document.getElementById(
        'modalEliminarSede'
      )
    );

  const btn =
    document.getElementById(
      'btnEliminarSede'
    );

  btn.onclick =
    confirmarEliminarSede;

  modalEliminarSede.show();
}

window.eliminarSedeVista =
  eliminarSedeVista;

async function confirmarEliminarSede(){

  try {

    mostrarLoader(
      'Inactivando sede...'
    );

    const respuesta =
      await eliminarSedeApi(
        sedeEliminar
      );

    ocultarLoader();

    if (!respuesta.ok){

      mostrarToast(
        respuesta.mensaje ||
        'No fue posible inactivar sede',
        'danger'
      );

      return;
    }

    modalEliminarSede.hide();

    mostrarToast(
      'Sede inactivada correctamente',
      'success'
    );

    await cargarSedes();

  } catch(error){

    console.error(error);

    ocultarLoader();

    mostrarToast(
      'Error al eliminar sede',
      'danger'
    );
  }
}