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
	
	
    <div class="table-toolbar">

      <div class="search-box">

        <i class="bi bi-search"></i>

        <input
          type="text"
          id="buscarSedes"
          placeholder="Buscar Sedes..."
        >

      </div>

    </div>
	
	${renderTablaSedes(datos)}

    `;
}

/* =========================================================
   MODAL NUEVA SEDE
========================================================= */

async function abrirModalNuevaSede(){

  editandoSede = null;

  document.getElementById(
    'formSede'
  ).reset();
  
  await cargarComboIpsSede();

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

      id_ips: document.getElementById('ipsSede').value
    };

    if (!datos.nombre){

      mostrarToast(
        'Ingrese nombre sede',
        'warning'
      );

      return;
    }
	
	if (!datos.id_ips){
	  mostrarToast('Seleccione una IPS', 'warning');
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

async function editarSede(id){
	
	await cargarComboIpsSede();

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
	
  document.getElementById('ipsSede').value =
  sede.id_ips || '';

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

async function cargarComboIpsSede(){

  const select =
    document.getElementById('ipsSede');

  select.innerHTML = `
    <option value="">
      Seleccione IPS
    </option>
  `;

  const respuesta =
    await listarIpsApi();

  const ipsActivas =
    (respuesta.datos || [])
      .filter(ips => ips.activo);

  ipsActivas.forEach(ips => {

    select.innerHTML += `
      <option value="${ips.id_ips}">
        ${ips.nombre} - ${ips.nit || 'Sin NIT'}
      </option>
    `;

  });
}

