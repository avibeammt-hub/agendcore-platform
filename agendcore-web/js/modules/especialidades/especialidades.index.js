let listaEspecialidades = [];
let especialidadEditar = null;
let especialidadEliminar = null;
let modalEliminarEspecialidad = null;

/* =========================================================
   CARGAR ESPECIALIDADES
========================================================= */

async function cargarEspecialidades() {

  try {

    mostrarLoader('Cargando especialidades...');

    const respuesta =
      await listarEspecialidadesApi();

    listaEspecialidades =
      respuesta.datos || [];

    renderModuloEspecialidades(
      listaEspecialidades
    );

    ocultarLoader();

  } catch(error){

    console.error(error);

    ocultarLoader();

    mostrarToast(
      'Error al cargar especialidades',
      'danger'
    );
  }
}

/* =========================================================
   RENDER
========================================================= */

function renderModuloEspecialidades(datos){

  const contenido =
    document.getElementById('contenido');

  document.getElementById(
    'tituloVista'
  ).textContent = 'Especialidades';

  document.getElementById(
    'subtituloVista'
  ).textContent =
    'Gestión interoperable de especialidades';

  contenido.innerHTML = `
    <div class="vista">

      <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
          <h2 class="fw-bold mb-1">
            Gestión de Especialidades
          </h2>

          <p class="text-muted">
            Crear, editar y consultar especialidades
          </p>
        </div>

        <button
          class="btn btn-primary btn-lg"
          onclick="abrirModalNuevaEspecialidad()">

          <i class="bi bi-plus-circle"></i>
          Nueva Especialidad
        </button>
      </div>

      <div class="row mb-4 g-3">

        <div class="col-md-4">
          <div class="kpi-card">

            <span class="kpi-label">
              ESPECIALIDADES
            </span>

            <h2 id="totalEspecialidades">
              0
            </h2>

            <div class="kpi-icon">
              <i class="bi bi-heart-pulse"></i>
            </div>

          </div>
        </div>

        <div class="col-md-4">
          <div class="kpi-card">

            <span class="kpi-label">
              ACTIVAS
            </span>

            <h2 id="especialidadesActivas">
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
            id="buscarEspecialidades"
            placeholder="Buscar especialidades...">

        </div>

      </div>

      <div id="contenedorTablaEspecialidades"></div>

    </div>
  `;

  document.getElementById(
    'totalEspecialidades'
  ).textContent =
    datos.length;

  document.getElementById(
    'especialidadesActivas'
  ).textContent =
    datos.filter(x => x.activo).length;

  document.getElementById(
    'contenedorTablaEspecialidades'
  ).innerHTML =
    renderTablaEspecialidades(datos);

  inicializarBusquedaEspecialidades();
}

/* =========================================================
   NUEVA ESPECIALIDAD
========================================================= */

async function abrirModalNuevaEspecialidad() {

  especialidadEditar = null;

  document.querySelector(
    '#modalEspecialidad .modal-title'
  ).textContent =
    'Nueva Especialidad';

  document.getElementById(
    'formEspecialidad'
  ).reset();

  const modal =
    new bootstrap.Modal(
      document.getElementById(
        'modalEspecialidad'
      )
    );

  modal.show();
}

window.abrirModalNuevaEspecialidad =
  abrirModalNuevaEspecialidad;

/* =========================================================
   GUARDAR
========================================================= */

async function guardarEspecialidad() {

  try {

    const datos = {

      nombre:
        document.getElementById(
          'nombreEspecialidad'
        ).value,

      codigo:
        document.getElementById(
          'codigoEspecialidad'
        ).value,

      activo:
        document.getElementById(
          'estadoEspecialidad'
        ).checked
    };

    if (!datos.nombre){

      mostrarToast(
        'Ingrese especialidad',
        'warning'
      );

      return;
    }

    if (!datos.codigo){

      mostrarToast(
        'Ingrese código especialidad',
        'warning'
      );

      return;
    }

    mostrarLoader(
      'Guardando especialidad...'
    );

    let respuesta;

    if (especialidadEditar) {

      respuesta =
        await actualizarEspecialidadApi(
          especialidadEditar,
          datos
        );

    } else {

      respuesta =
        await crearEspecialidadApi(
          datos
        );
    }

    ocultarLoader();

    if (!respuesta.ok){

      mostrarToast(
        respuesta.mensaje ||
        'No fue posible guardar especialidad',
        'danger'
      );

      return;
    }

    bootstrap.Modal
      .getInstance(
        document.getElementById(
          'modalEspecialidad'
        )
      )
      .hide();

    mostrarToast(
      especialidadEditar
        ? 'Especialidad actualizada'
        : 'Especialidad creada',
      'success'
    );

    await cargarEspecialidades();

  } catch (error) {

    console.error(error);

    ocultarLoader();

    mostrarToast(
      'Error al guardar especialidad',
      'danger'
    );
  }
}

window.guardarEspecialidad =
  guardarEspecialidad;

/* =========================================================
   EDITAR
========================================================= */

function editarEspecialidad(id) {

  const esp =
    listaEspecialidades.find(
      e => e.id_especialidad == id
    );

  if (!esp) return;

  especialidadEditar = id;

  document.querySelector(
    '#modalEspecialidad .modal-title'
  ).textContent =
    'Editar Especialidad';

  document.getElementById(
    'nombreEspecialidad'
  ).value =
    esp.nombre || '';

  document.getElementById(
    'codigoEspecialidad'
  ).value =
    esp.codigo || '';

  document.getElementById(
    'estadoEspecialidad'
  ).checked =
    esp.activo;

  const modal =
    new bootstrap.Modal(
      document.getElementById(
        'modalEspecialidad'
      )
    );

  modal.show();
}

window.editarEspecialidad =
  editarEspecialidad;

/* =========================================================
   ELIMINAR
========================================================= */

function eliminarEspecialidadVista(id) {

  especialidadEliminar = id;

  modalEliminarEspecialidad =
    new bootstrap.Modal(
      document.getElementById(
        'modalEliminarEspecialidad'
      )
    );
	
	const btn =
    document.getElementById(
      'btnEliminarEspecialidad'
    );

	btn.onclick =
    confirmarEliminarEspecialidad;

  modalEliminarEspecialidad.show();
}

window.eliminarEspecialidadVista =
  eliminarEspecialidadVista;

async function confirmarEliminarEspecialidad() {

  try {

    mostrarLoader(
      'Eliminando especialidad...'
    );

    const respuesta =
      await eliminarEspecialidadApi(
        especialidadEliminar
      );

    ocultarLoader();

    if (!respuesta.ok){

      mostrarToast(
        respuesta.mensaje ||
        'No fue posible eliminar especialidad',
        'danger'
      );

      return;
    }

    modalEliminarEspecialidad.hide();

    mostrarToast(
      'Especialidad eliminada correctamente',
      'success'
    );

    await cargarEspecialidades();

  } catch(error){

    console.error(error);

    ocultarLoader();

    mostrarToast(
      'Error al eliminar especialidad',
      'danger'
    );
  }
}

window.confirmarEliminarEspecialidad =
  confirmarEliminarEspecialidad;

/* =========================================================
   BUSCADOR
========================================================= */

function inicializarBusquedaEspecialidades() {

  const input =
    document.getElementById(
      'buscarEspecialidades'
    );

  input.addEventListener('keyup', e => {

    const texto =
      e.target.value.toLowerCase();

    const filtrado =
      listaEspecialidades.filter(esp => {

        return (

          esp.nombre
            ?.toLowerCase()
            .includes(texto)

          ||

          esp.codigo
            ?.toLowerCase()
            .includes(texto)

        );

      });

    document.getElementById(
      'contenedorTablaEspecialidades'
    ).innerHTML =
      renderTablaEspecialidades(
        filtrado
      );

    document.getElementById(
      'totalEspecialidades'
    ).textContent =
      filtrado.length;

    document.getElementById(
      'especialidadesActivas'
    ).textContent =
      filtrado.filter(
        x => x.activo
      ).length;

  });
}