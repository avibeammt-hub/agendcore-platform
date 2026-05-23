function renderTablaEspecialidades(datos) {

  if (!datos || datos.length === 0) {
    return `
      <div class="empty-state">
        <div class="empty-icon">
          <i class="bi bi-heart-pulse"></i>
        </div>

        <h4>No hay especialidades registradas</h4>

        <p>
          Comienza creando tu primera especialidad.
        </p>

        <button
          class="btn btn-primary btn-lg"
          onclick="abrirModalNuevaEspecialidad()">
          <i class="bi bi-plus-circle"></i>
          Nueva Especialidad
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
              <th>Especialidad</th>
              <th>Código</th>
              <th>Estado</th>
              <th class="text-end">Acciones</th>
            </tr>
          </thead>

          <tbody>
            ${datos.map(esp => `
              <tr>
                <td>
                  <span class="table-id">
                    #${esp.id_especialidad}
                  </span>
                </td>

                <td>
                  <div class="ips-info">
                    <div class="ips-avatar">
                      <i class="bi bi-heart-pulse"></i>
                    </div>

                    <div>
                      <div class="ips-name">
                        ${esp.nombre || ''}
                      </div>

                      <div class="ips-subtitle">
                        Catálogo clínico
                      </div>
                    </div>
                  </div>
                </td>

                <td>
                  <span class="table-text">
                    ${esp.codigo || 'Sin código'}
                  </span>
                </td>

                <td>
                  ${
                    esp.activo
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
                      onclick="editarEspecialidad(${esp.id_especialidad})">
                      <i class="bi bi-pencil"></i>
                    </button>

                    <button
                      class="btn-action delete"
                      onclick="eliminarEspecialidadVista(${esp.id_especialidad})">
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