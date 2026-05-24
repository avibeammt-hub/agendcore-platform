let listaServicios = [];
let servicioEditar = null;
let servicioEliminar = null;
let modalEliminarServicio = null;

/* =========================================================
   CARGAR SERVICIOS
========================================================= */

async function cargarServicios() {

  try {

    mostrarLoader(
      'Cargando servicios...'
    );

    const respuesta =
      await listarServiciosApi();

    listaServicios =
      respuesta.datos || [];

    renderModuloServicios(
      listaServicios
    );

    ocultarLoader();

  } catch(error){

    console.error(error);

    ocultarLoader();

    mostrarToast(
      'Error al cargar servicios',
      'danger'
    );
  }
}

/* =========================================================
   RENDER
========================================================= */

function renderModuloServicios(datos){

  const contenido =
    document.getElementById(
      'contenido'
    );

  document.getElementById(
    'tituloVista'
  ).textContent =
    'Servicios';

  document.getElementById(
    'subtituloVista'
  ).textContent =
    'Gestión interoperable de servicios';

  contenido.innerHTML = `
    <div class="vista">

      <div class="d-flex justify-content-between align-items-center mb-4">

        <div>

          <h2 class="fw-bold mb-1">
            Gestión de Servicios
          </h2>

          <p class="text-muted">
            Administración de servicios sincronizados con FHIR
          </p>

        </div>

        <button
          class="btn btn-primary btn-lg"
          onclick="abrirModalNuevoServicio()">

          <i class="bi bi-plus-circle"></i>
          Nuevo Servicio

        </button>

      </div>

      <div class="row mb-4 g-3">

        <div class="col-md-4">

          <div class="kpi-card">

            <span class="kpi-label">
              SERVICIOS
            </span>

            <h2 id="totalServicios">
              0
            </h2>

            <div class="kpi-icon">
              <i class="bi bi-clipboard2-pulse"></i>
            </div>

          </div>

        </div>

        <div class="col-md-4">

          <div class="kpi-card">

            <span class="kpi-label">
              ACTIVOS
            </span>

            <h2 id="serviciosActivos">
              0
            </h2>

            <div class="kpi-icon success">
              <i class="bi bi-check-circle"></i>
            </div>

          </div>

        </div>

        <div class="col-md-4">

          <div class="kpi-card">

            <span class="kpi-label">
              ESTADO
            </span>

            <h2>
              ONLINE
            </h2>

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
            id="buscarServicios"
            placeholder="Buscar servicios...">

        </div>

      </div>

      <div id="contenedorTablaServicios"></div>

    </div>
  `;

  document.getElementById(
    'totalServicios'
  ).textContent =
    datos.length;

  document.getElementById(
    'serviciosActivos'
  ).textContent =
    datos.filter(
      x => x.activo
    ).length;

  document.getElementById(
    'contenedorTablaServicios'
  ).innerHTML =
    renderTablaServicios(datos);

  inicializarBusquedaServicios();
}

/* =========================================================
   MODAL NUEVO
========================================================= */

async function abrirModalNuevoServicio() {

  servicioEditar = null;

  document.querySelector(
    '#modalServicio .modal-title'
  ).textContent =
    'Nuevo Servicio';

  document.getElementById(
    'formServicio'
  ).reset();

  await cargarCombosServicio();

  const modal =
    new bootstrap.Modal(
      document.getElementById(
        'modalServicio'
      )
    );

  modal.show();
}

window.abrirModalNuevoServicio =
  abrirModalNuevoServicio;

/* =========================================================
   COMBOS
========================================================= */

async function cargarCombosServicio() {

  const [
    ips,
    sedes,
    especialidades
  ] = await Promise.all([

    listarIpsApi(),
    listarSedesApi(),
    listarEspecialidadesApi()

  ]);

  const selectIps =
    document.getElementById(
      'ipsServicio'
    );

  const selectSedes =
    document.getElementById(
      'sedeServicio'
    );

  const selectEspecialidades =
    document.getElementById(
      'especialidadServicio'
    );

  selectIps.innerHTML =
    `
      <option value="">
        Seleccione IPS
      </option>
    `;

  (ips.datos || []).forEach(ips => {

    selectIps.innerHTML += `
      <option value="${ips.id_ips}">
        ${ips.nombre}
      </option>
    `;
  });

  selectEspecialidades.innerHTML =
    `
      <option value="">
        Seleccione especialidad
      </option>
    `;

  (especialidades.datos || [])
    .forEach(esp => {

      selectEspecialidades.innerHTML += `
        <option value="${esp.id_especialidad}">
          ${esp.nombre}
        </option>
      `;
    });

  selectIps.onchange = () => {

    const idIps =
      selectIps.value;

    selectSedes.innerHTML =
      `
        <option value="">
          Seleccione sede
        </option>
      `;

    (sedes.datos || [])
      .filter(
        s => s.id_ips == idIps
      )
      .forEach(sede => {

        selectSedes.innerHTML += `
          <option value="${sede.id_sede}">
            ${sede.nombre}
          </option>
        `;
      });
  };
}

/* =========================================================
   GUARDAR
========================================================= */

async function guardarServicio() {

  try {

    const datos = {

      id_ips:
        document.getElementById(
          'ipsServicio'
        ).value,

      id_sede:
        document.getElementById(
          'sedeServicio'
        ).value,

      id_especialidad:
        document.getElementById(
          'especialidadServicio'
        ).value || null,

      nombre:
        document.getElementById(
          'nombreServicio'
        ).value,

      descripcion:
        document.getElementById(
          'descripcionServicio'
        ).value
    };

    if (!datos.id_ips){

      mostrarToast(
        'Seleccione IPS',
        'warning'
      );

      return;
    }

    if (!datos.id_sede){

      mostrarToast(
        'Seleccione sede',
        'warning'
      );

      return;
    }

    if (!datos.nombre){

      mostrarToast(
        'Ingrese nombre servicio',
        'warning'
      );

      return;
    }

    mostrarLoader(
      'Guardando servicio...'
    );

    let respuesta;

    if (servicioEditar){

      respuesta =
        await actualizarServicioApi(
          servicioEditar,
          datos
        );

    } else {

      respuesta =
        await crearServicioApi(
          datos
        );
    }

    ocultarLoader();

    if (!respuesta.ok){

      mostrarToast(
        respuesta.mensaje ||
        'No fue posible guardar servicio',
        'danger'
      );

      return;
    }

    bootstrap.Modal
      .getInstance(
        document.getElementById(
          'modalServicio'
        )
      )
      .hide();

    mostrarToast(
      servicioEditar
        ? 'Servicio actualizado'
        : 'Servicio creado',
      'success'
    );

    await cargarServicios();

  } catch(error){

    console.error(error);

    ocultarLoader();

    mostrarToast(
      'Error al guardar servicio',
      'danger'
    );
  }
}

window.guardarServicio =
  guardarServicio;

/* =========================================================
   EDITAR
========================================================= */

async function editarServicio(id) {

  const servicio =
    listaServicios.find(
      x => x.id_servicio == id
    );

  if (!servicio) return;

  servicioEditar = id;

  await cargarCombosServicio();

  document.querySelector(
    '#modalServicio .modal-title'
  ).textContent =
    'Editar Servicio';

  document.getElementById(
    'ipsServicio'
  ).value =
    servicio.id_ips;

  document.getElementById(
    'ipsServicio'
  ).dispatchEvent(
    new Event('change')
  );

  setTimeout(() => {

    document.getElementById(
      'sedeServicio'
    ).value =
      servicio.id_sede;

  }, 200);

  document.getElementById(
    'especialidadServicio'
  ).value =
    servicio.id_especialidad || '';

  document.getElementById(
    'nombreServicio'
  ).value =
    servicio.nombre || '';

  document.getElementById(
    'descripcionServicio'
  ).value =
    servicio.descripcion || '';

  const modal =
    new bootstrap.Modal(
      document.getElementById(
        'modalServicio'
      )
    );

  modal.show();
}

window.editarServicio =
  editarServicio;

/* =========================================================
   ELIMINAR
========================================================= */

function eliminarServicioVista(id) {

  servicioEliminar = id;

  modalEliminarServicio =
    new bootstrap.Modal(
      document.getElementById(
        'modalEliminarServicio'
      )
    );

  const btn =
    document.getElementById(
      'btnEliminarServicio'
    );

  btn.onclick =
    confirmarEliminarServicio;

  modalEliminarServicio.show();
}

window.eliminarServicioVista =
  eliminarServicioVista;

async function confirmarEliminarServicio() {

  try {

    mostrarLoader(
      'Inactivando servicio...'
    );

    const respuesta =
      await eliminarServicioApi(
        servicioEliminar
      );

    ocultarLoader();

    if (!respuesta.ok){

      mostrarToast(
        respuesta.mensaje ||
        'No fue posible inactivar servicio',
        'danger'
      );

      return;
    }

    modalEliminarServicio.hide();

    mostrarToast(
      'Servicio inactivado correctamente',
      'success'
    );

    await cargarServicios();

  } catch(error){

    console.error(error);

    ocultarLoader();

    mostrarToast(
      'Error al eliminar servicio',
      'danger'
    );
  }
}

window.confirmarEliminarServicio =
  confirmarEliminarServicio;

/* =========================================================
   BUSCADOR
========================================================= */

function inicializarBusquedaServicios() {

  const input =
    document.getElementById(
      'buscarServicios'
    );

  input.addEventListener(
    'keyup',
    e => {

      const texto =
        e.target.value
          .toLowerCase();

      const filtrado =
        listaServicios.filter(
          servicio => {

            return (

              servicio.nombre
                ?.toLowerCase()
                .includes(texto)

              ||

              servicio.nombre_ips
                ?.toLowerCase()
                .includes(texto)

              ||

              servicio.nombre_sede
                ?.toLowerCase()
                .includes(texto)

              ||

              servicio.nombre_especialidad
                ?.toLowerCase()
                .includes(texto)

            );
          }
        );

      document.getElementById(
        'contenedorTablaServicios'
      ).innerHTML =
        renderTablaServicios(
          filtrado
        );

      document.getElementById(
        'totalServicios'
      ).textContent =
        filtrado.length;

      document.getElementById(
        'serviciosActivos'
      ).textContent =
        filtrado.filter(
          x => x.activo
        ).length;
    }
  );
}

window.cargarServicios =
  cargarServicios;