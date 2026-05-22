function renderTablaSedes(datos) {

  if (!datos || datos.length === 0) {

    return `
      <div class="empty-state">

        <div class="empty-icon">
          <i class="bi bi-geo-alt"></i>
        </div>

        <h4>No hay sedes registradas</h4>

        <p>
          Comienza creando tu primera sede
          interoperable sincronizada con FHIR.
        </p>

        <button
          class="btn btn-primary btn-lg"
          onclick="abrirModalNuevaSede()">

          <i class="bi bi-plus-circle"></i>
          Nueva Sede

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
              <th>Sede</th>
              <th>Identificador</th>
              <th>FHIR</th>
              <th>Estado</th>
              <th class="text-end">Acciones</th>
            </tr>

          </thead>

          <tbody>

            ${datos.map(sede => `

              <tr>

                <td>

                  <span class="table-id">
                    #${sede.id_sede}
                  </span>

                </td>

                <td>

                  <div class="ips-info">

                    <div class="ips-avatar">
                      <i class="bi bi-geo-alt"></i>
                    </div>

                    <div>

                      <div class="ips-name">
                        ${sede.nombre || ''}
                      </div>

                      <div class="ips-subtitle">
                        ${sede.direccion || 'Sin dirección'}
                      </div>

                    </div>

                  </div>

                </td>

                <td>

                  <span class="table-text">
                    ${sede.identificador || 'Sin identificador'}
                  </span>

                </td>

                <td>

                  ${
                    sede.fhir_id
                    ? `
                      <span class="badge-fhir success">
                        <i class="bi bi-cloud-check"></i>
                        ${sede.fhir_id}
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
                    sede.activo
                    ? `
                      <span class="badge-status active">
                        <span class="dot"></span>
                        Activa
                      </span>
                    `
                    : `
                      <span class="badge-status inactive">
                        <span class="dot"></span>
                        Inactiva
                      </span>
                    `
                  }

                </td>

                <td class="text-end">

                  <div class="acciones-group">

                    <button
                      class="btn-action edit"
                      onclick="editarSede(${sede.id_sede})">

                      <i class="bi bi-pencil"></i>

                    </button>

                    <button
                      class="btn-action delete"
                      onclick="eliminarSedeVista(${sede.id_sede})">

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