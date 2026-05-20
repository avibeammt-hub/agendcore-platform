function renderTablaIps(datos) {

  if (!datos || datos.length === 0) {

    return `
      <div class="empty-state">

        <div class="empty-icon">
          <i class="bi bi-building"></i>
        </div>

        <h4>No hay IPS registradas</h4>

        <p>
          Comienza creando tu primera institución
          sincronizada con FHIR.
        </p>

        <button
          class="btn btn-primary btn-lg"
          onclick="abrirModalNuevaIps()">

          <i class="bi bi-plus-circle"></i>
          Nueva IPS

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
              <th>Institución</th>
              <th>NIT</th>
              <th>FHIR</th>
              <th>Estado</th>
              <th class="text-end">Acciones</th>
            </tr>

          </thead>

          <tbody>

            ${datos.map(ips => `

              <tr>

                <td>
                  <span class="table-id">
                    #${ips.id_ips}
                  </span>
                </td>

                <td>

                  <div class="ips-info">

                    <div class="ips-avatar">
                      <i class="bi bi-building"></i>
                    </div>

                    <div>

                      <div class="ips-name">
                        ${ips.nombre}
                      </div>

                      <div class="ips-subtitle">
                        ${ips.razon_social || 'Sin razón social'}
                      </div>

                    </div>

                  </div>

                </td>

                <td>

                  <span class="table-text">
                    ${ips.nit || 'Sin NIT'}
                  </span>

                </td>

                <td>

                  ${
                    ips.fhir_id
                    ? `
                      <span class="badge-fhir success">
                        <i class="bi bi-cloud-check"></i>
                        ${ips.fhir_id}
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
                    ips.activo
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
                      onclick="editarIps(${ips.id_ips})">

                      <i class="bi bi-pencil"></i>

                    </button>

                    <button
                      class="btn-action delete"
                      onclick="eliminarIpsVista(${ips.id_ips})">

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