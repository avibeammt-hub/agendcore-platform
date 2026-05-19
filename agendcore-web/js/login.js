const API_BASE = 'http://localhost:3000/api';

const formLogin = document.getElementById('formLogin');
const usuarioInput = document.getElementById('usuario');
const claveInput = document.getElementById('clave');
const rolInput = document.getElementById('rol');
const mensajeLogin = document.getElementById('mensajeLogin');
const btnVerClave = document.getElementById('btnVerClave');

btnVerClave.addEventListener('click', () => {
  const tipo = claveInput.type === 'password' ? 'text' : 'password';
  claveInput.type = tipo;
  btnVerClave.innerHTML = tipo === 'password'
    ? '<i class="bi bi-eye"></i>'
    : '<i class="bi bi-eye-slash"></i>';
});

formLogin.addEventListener('submit', async (e) => {
  e.preventDefault();

  const usuario = usuarioInput.value.trim();
  const clave = claveInput.value.trim();

  if (!usuario || !clave) {
    mostrarMensaje('Ingrese usuario y contraseña.', 'danger');
    return;
  }

  try {
    const res = await fetch(`${API_BASE}/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ usuario, clave })
    });

    const data = await res.json();

    if (!res.ok || data.estado !== 'OK') {
      mostrarMensaje(data.mensaje || 'Credenciales inválidas.', 'danger');
      return;
    }

    if (rolInput.value && rolInput.value !== data.usuario.rol) {
      mostrarMensaje('El rol seleccionado no corresponde al usuario.', 'danger');
      return;
    }

    localStorage.setItem('token', data.token);
    localStorage.setItem('usuarioSesion', JSON.stringify(data.usuario));

    mostrarMensaje('Ingreso exitoso. Redirigiendo...', 'success');

    setTimeout(() => {
      window.location.href = 'dashboard.html';
    }, 800);

  } catch (error) {
    console.error(error);
    mostrarMensaje('No fue posible conectar con el backend.', 'danger');
  }
});

function mostrarMensaje(texto, tipo) {
  mensajeLogin.className = `alert alert-${tipo}`;
  mensajeLogin.textContent = texto;
  mensajeLogin.classList.remove('d-none');
}