function renderTablaIps(datos) {

  if (!datos || datos.length === 0) {
    return `
      <div class="alert alert-info">
        No hay IPS registradas
      </div>
    `;
  }

  return `
    <div class="table-responsive">

      <table class="table table-hover align-middle">

        <thead class="table-light">
          <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>NIT</th>
            <th>FHIR</th>
            <th>Estado</th>
            <th class="text-end">Acciones</th>
          </tr>
        </thead>

        <tbody>

          ${datos.map(ips => `
            <tr>

              <td>${ips.id_ips}</td>

              <td>
                <strong>${ips.nombre}</strong>
                <br>
                <small class="text-muted">
                  ${ips.razon_social || ''}
                </small>
              </td>

              <td>${ips.nit || ''}</td>

              <td>
                <span class="badge bg-info">
                  ${ips.fhir_id || 'Pendiente'}
                </span>
              </td>

              <td>
                <span class="badge ${ips.activo ? 'bg-success' : 'bg-secondary'}">
                  ${ips.activo ? 'Activo' : 'Inactivo'}
                </span>
              </td>

              <td class="text-end">

                <button
                  class="btn btn-sm btn-outline-primary"
                  onclick="editarIps(${ips.id_ips})">

                  <i class="bi bi-pencil"></i>

                </button>

                <button
                  class="btn btn-sm btn-outline-danger"
                  onclick="eliminarIpsVista(${ips.id_ips})">

                  <i class="bi bi-trash"></i>

                </button>

              </td>

            </tr>
          `).join('')}

        </tbody>

      </table>

    </div>
  `;
}