const API_BASE = 'https://agendcore-platform.onrender.com/api';

function obtenerToken() {
  return localStorage.getItem('token');
}

function headersAuth() {
  return {
    'Content-Type': 'application/json',
    Authorization: `Bearer ${obtenerToken()}`
  };
}

async function peticion(url, opciones = {}) {
  const respuesta = await fetch(url, {
    ...opciones,
    headers: {
      ...headersAuth(),
      ...(opciones.headers || {})
    }
  });

  if (respuesta.status === 401 || respuesta.status === 403) {
    localStorage.clear();
    window.location.href = 'index.html';
    return;
  }

  return respuesta;
}