async function listarSedesApi() {

  const res =
    await peticion(
      `${API_BASE}/sedes`
    );

  return await res.json();
}

async function crearSedeApi(datos){

  const res =
    await peticion(
      `${API_BASE}/sedes`,
      {
        method: 'POST',
        body: JSON.stringify(datos)
      }
    );

  return await res.json();
}

async function actualizarSedeApi(
  id,
  datos
){

  const res =
    await peticion(
      `${API_BASE}/sedes/${id}`,
      {
        method: 'PUT',
        body: JSON.stringify(datos)
      }
    );

  return await res.json();
}

async function eliminarSedeApi(id){

  const res =
    await peticion(
      `${API_BASE}/sedes/${id}`,
      {
        method: 'DELETE'
      }
    );

  return await res.json();
}