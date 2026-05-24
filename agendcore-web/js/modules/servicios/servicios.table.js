function renderTablaServicios(datos) {

  if (!datos || datos.length === 0) {
    return `
      <div class="empty-state">

        <div class="empty-icon">
          <i class="bi bi-clipboard2-pulse"></i>
        </div>

        <h4>No hay servicios registrados</h4>

        <p>
          Comienza creando tu primer servicio de salud.
        </p>

        <button
          class="btn btn-primary btn-lg"
          onclick="abrirModalNuevoServicio()">

          <i class="bi bi-plus-circle"></i>
          Nuevo Servicio

        </button>

      </div>
    `;
  }

  return `
    <div class="table-card">
      <div class="table-responsive">

        <table class="table table-modern align-middle">

          <thead>
            <tr>
              <th>ID</th>
              <th>Servicio</th>
              <th>IPS / Sede</th>
              <th>Especialidad</th>
              <th>FHIR</th>
              <th>Estado</th>
              <th class="text-end">Acciones</th>
            </tr>
          </thead>

          <tbody>

            ${datos.map(servicio => `
              <tr>

                <td>
                  <span class="table-id">
                    #${servicio.id_servicio}
                  </span>
                </td>

                <td>
                  <div class="ips-info">

                    <div class="ips-avatar">
                      <i class="bi bi-clipboard2-pulse"></i>
                    </div>

                    <div>
                      <div class="ips-name">
                        ${servicio.nombre || ''}
                      </div>

                      <div class="ips-subtitle">
                        ${servicio.descripcion || 'Sin descripción'}
                      </div>
                    </div>

                  </div>
                </td>

                <td>
                  <div class="table-text">
                    <strong>${servicio.nombre_ips || 'Sin IPS'}</strong>
                    <br>
                    <small class="text-muted">
                      ${servicio.nombre_sede || 'Sin sede'}
                    </small>
                  </div>
                </td>

                <td>
                  <span class="table-text">
                    ${servicio.nombre_especialidad || 'Sin especialidad'}
                  </span>
                </td>

                <td>
                  ${
                    servicio.fhir_id
                    ? `
                      <span class="badge-fhir success">
                        <i class="bi bi-cloud-check"></i>
                        ${servicio.fhir_id}
                      </span>
                    `
                    : `
                      <span class="badge-fhir pending">
                        <i class="bi bi-cloud-slash"></i>
                        Pendiente
                      </span>
                    `
                  }
                </td>

                <td>
                  ${
                    servicio.activo
                    ? `
                      <span class="badge-status active">
                        <span class="dot"></span>
                        Activo
                      </span>
                    `
                    : `
                      <span class="badge-status inactive">
                        <span class="dot"></span>
                        Inactivo
                      </span>
                    `
                  }
                </td>

                <td class="text-end">
                  <div class="acciones-group">

                    <button
                      class="btn-action edit"
                      onclick="editarServicio(${servicio.id_servicio})">

                      <i class="bi bi-pencil"></i>

                    </button>

                    <button
                      class="btn-action delete"
                      onclick="eliminarServicioVista(${servicio.id_servicio})">

                      <i class="bi bi-trash"></i>

                    </button>

                  </div>
                </td>

              </tr>
            `).join('')}

          </tbody>

        </table>

      </div>
    </div>
  `;
}