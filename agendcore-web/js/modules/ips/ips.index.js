let listaIps = [];

async function cargarIps() {

  try {

    mostrarLoader('Cargando IPS...');

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