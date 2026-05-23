async function listarEspecialidadesApi() {
  const res = await peticion(`${API_BASE}/especialidades`);
  return await res.json();
}

async function crearEspecialidadApi(datos) {
  const res = await peticion(`${API_BASE}/especialidades`, {
    method: 'POST',
    body: JSON.stringify(datos)
  });

  return await res.json();
}

async function actualizarEspecialidadApi(id, datos) {
  const res = await peticion(`${API_BASE}/especialidades/${id}`, {
    method: 'PUT',
    body: JSON.stringify(datos)
  });

  return await res.json();
}

async function eliminarEspecialidadApi(id) {
  const res = await peticion(`${API_BASE}/especialidades/${id}`, {
    method: 'DELETE'
  });

  return await res.json();
}