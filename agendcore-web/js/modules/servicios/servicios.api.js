async function listarServiciosApi() {
  const res = await peticion(`${API_BASE}/servicios`);
  return await res.json();
}

async function crearServicioApi(datos) {
  const res = await peticion(`${API_BASE}/servicios`, {
    method: 'POST',
    body: JSON.stringify(datos)
  });

  return await res.json();
}

async function actualizarServicioApi(id, datos) {
  const res = await peticion(`${API_BASE}/servicios/${id}`, {
    method: 'PUT',
    body: JSON.stringify(datos)
  });

  return await res.json();
}

async function eliminarServicioApi(id) {
  const res = await peticion(`${API_BASE}/servicios/${id}`, {
    method: 'DELETE'
  });

  return await res.json();
}