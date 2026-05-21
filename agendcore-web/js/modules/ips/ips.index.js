let listaIps = [];

async function cargarIps() {

  try {

    mostrarLoader('Cargando IPS...');
	
	document.getElementById('contenido').innerHTML = `

	  <div class="vista">

		<div class="d-flex justify-content-between mb-4">

		  <div>
			<div class="skeleton mb-3" style="width:260px;height:40px"></div>
			<div class="skeleton" style="width:380px;height:20px"></div>
		  </div>

		  <div class="skeleton" style="width:180px;height:56px"></div>

		</div>

		<div class="row mb-4">

		  <div class="col-md-4">
			<div class="skeleton" style="height:120px"></div>
		  </div>

		  <div class="col-md-4">
			<div class="skeleton" style="height:120px"></div>
		  </div>

		  <div class="col-md-4">
			<div class="skeleton" style="height:120px"></div>
		  </div>

		</div>

		<div class="skeleton mb-3" style="height:55px"></div>

		<div class="skeleton mb-3" style="height:70px"></div>
		<div class="skeleton mb-3" style="height:70px"></div>
		<div class="skeleton mb-3" style="height:70px"></div>
		<div class="skeleton mb-3" style="height:70px"></div>

	  </div>
	`;

    const respuesta = await listarIpsApi();
	
	listaIps = respuesta.datos || [];

	renderModuloIps(listaIps);

    ocultarLoader();

  } catch (error) {

    console.error(error);

    ocultarLoader();

    mostrarToast(
      'No fue posible cargar IPS',
      'danger'
    );
  }
}

function renderModuloIps(datos) {

  const contenido = document.getElementById('contenido');

  document.getElementById('tituloVista').textContent = 'IPS';

  document.getElementById('subtituloVista').textContent =
    'Administración de Instituciones Prestadoras de Servicios';

  contenido.innerHTML = `

    <div class="d-flex justify-content-between align-items-center mb-4">

      <div>
        <h2 class="fw-bold mb-1">
          Gestión de IPS
        </h2>

        <p class="text-muted">
          Crear, editar y consultar IPS sincronizadas con FHIR
        </p>
      </div>

      <button
        class="btn btn-primary btn-lg"
        onclick="abrirModalNuevaIps()">

        <i class="bi bi-plus-circle"></i>
        Nueva IPS

      </button>

    </div>

    <div class="row mb-4 g-3">

      <div class="col-md-4">
        <div class="kpi-card">
          <div>
            <span class="kpi-label">IPS ACTIVAS</span>
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
            <span class="kpi-label">FHIR SYNC</span>
            <h2>
              ${datos.filter(x => x.fhir_id).length}
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
            <span class="kpi-label">ESTADO</span>
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
          id="buscarIps"
          placeholder="Buscar IPS..."
        >

      </div>

    </div>

    ${renderTablaIps(datos)}

  `;

  inicializarBusquedaIps();
}

/* =========================================================
   MODAL IPS
========================================================= */

let modalIps = null;

function abrirModalNuevaIps(){

  editandoIps = null;
  document.getElementById('formIps').reset();

  document.querySelector(
    '#modalIps .modal-title'
  ).textContent = 'Nueva IPS';

  modalIps = new bootstrap.Modal(
    document.getElementById('modalIps')
  );

  modalIps.show();
}

window.abrirModalNuevaIps = abrirModalNuevaIps;

/* =========================================================
   GUARDAR IPS
========================================================= */

async function guardarIps() {

  try {

    

    const datos = {

      nombre:
        document.getElementById('nombreIps').value,

      razon_social:
        document.getElementById('razonSocialIps').value,

      nit:
        document.getElementById('nitIps').value,

      codigo_habilitacion:
        document.getElementById('codigoHabilitacionIps').value,

      telefono:
        document.getElementById('telefonoIps').value,

      correo:
        document.getElementById('correoIps').value,

      direccion:
        document.getElementById('direccionIps').value

    };
	
	/* VALIDACIONES */

	if (!datos.nombre) {
	  ocultarLoader();
	  mostrarToast('Ingrese nombre IPS', 'warning');
	  return;
	}

	if (!datos.nit) {
	  ocultarLoader();
	  mostrarToast('Ingrese NIT', 'warning');
	  return;
	}
	
	mostrarLoader('Guardando IPS...');
    
	let respuesta;

	if (editandoIps) {

	  respuesta = await actualizarIpsApi(
		editandoIps,
		datos
	  );

	}else {

	  respuesta = await crearIpsApi(datos);

	}

    ocultarLoader();

    if (!respuesta.ok) {

      mostrarToast(
        respuesta.mensaje || 'Error al crear IPS',
        'danger'
      );

      return;
    }

    modalIps.hide();
	editandoIps = null;

    mostrarToast(
	  respuesta.mensaje ||
	  (editandoIps
		? 'IPS actualizada correctamente'
		: 'IPS creada correctamente'),
	  'success'
	);

    await cargarIps();

  } catch (error) {

    console.error(error);

    ocultarLoader();

    mostrarToast(
      'Error al guardar IPS',
      'danger'
    );
  }
}

window.guardarIps = guardarIps;

/* =========================================================
   EDITAR IPS
========================================================= */

let editandoIps = null;

function editarIps(id) {

  const ips = listaIps.find(x => x.id_ips == id);

  if (!ips) {
    mostrarToast('IPS no encontrada', 'danger');
    return;
  }

  editandoIps = id;

  document.querySelector(
    '#modalIps .modal-title'
  ).textContent = 'Editar IPS';

  document.getElementById('nombreIps').value =
    ips.nombre || '';

  document.getElementById('razonSocialIps').value =
    ips.razon_social || '';

  document.getElementById('nitIps').value =
    ips.nit || '';

  document.getElementById('codigoHabilitacionIps').value =
    ips.codigo_habilitacion || '';

  document.getElementById('telefonoIps').value =
    ips.telefono || '';

  document.getElementById('correoIps').value =
    ips.correo || '';

  document.getElementById('direccionIps').value =
    ips.direccion || '';

  modalIps = new bootstrap.Modal(
    document.getElementById('modalIps')
  );

  modalIps.show();
}

window.editarIps = editarIps;

/* =========================================================
   ELIMINAR IPS
========================================================= */

let ipsEliminar = null;
let modalEliminarIps = null;

function eliminarIpsVista(id){

  ipsEliminar = id;

  modalEliminarIps =
    new bootstrap.Modal(
      document.getElementById(
        'modalEliminarIps'
      )
    );

  modalEliminarIps.show();
}

window.eliminarIpsVista = eliminarIpsVista;

async function confirmarEliminarIps(){

  if (!ipsEliminar) return;

  try {

    modalEliminarIps.hide();

    mostrarLoader(
      'Inactivando IPS...'
    );

    const respuesta =
      await eliminarIpsApi(
        ipsEliminar
      );

    ocultarLoader();

    if (!respuesta.ok){

      mostrarToast(
        respuesta.mensaje ||
        'No fue posible inactivar IPS',
        'danger'
      );

      return;
    }

    mostrarToast(
      respuesta.mensaje ||
      'IPS inactivada correctamente',
      'success'
    );

    ipsEliminar = null;

    await cargarIps();

  } catch(error){

    console.error(error);

    ocultarLoader();

    mostrarToast(
      'Error al inactivar IPS',
      'danger'
    );
  }
}

window.confirmarEliminarIps =
  confirmarEliminarIps;

function inicializarBusquedaIps() {

  const input = document.getElementById('buscarIps');

  input.addEventListener('keyup', e => {

    const texto = e.target.value.toLowerCase();

    const filtrado = listaIps.filter(ips => {

      return (
        ips.nombre?.toLowerCase().includes(texto) ||
        ips.nit?.toLowerCase().includes(texto)
      );

    });

    document.querySelector('.table-responsive').outerHTML =
      renderTablaIps(filtrado);

  });
}