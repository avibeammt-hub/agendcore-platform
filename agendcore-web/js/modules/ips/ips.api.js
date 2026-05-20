async function listarIpsApi() {
  const res = await peticion(`${API_BASE}/ips`);
  return await res.json();
}

async function crearIpsApi(datos) {
  const res = await peticion(`${API_BASE}/ips`, {
    method: 'POST',
    body: JSON.stringify(datos)
  });

  return await res.json();
}

async function actualizarIpsApi(id, datos) {
  const res = await peticion(`${API_BASE}/ips/${id}`, {
    method: 'PUT',
    body: JSON.stringify(datos)
  });

  return await res.json();
}

async function eliminarIpsApi(id) {
  const res = await peticion(`${API_BASE}/ips/${id}`, {
    method: 'DELETE'
  });

  return await res.json();
}