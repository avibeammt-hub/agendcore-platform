const API_BASE = 'https://agendcore-platform.onrender.com/api';

const formLogin = document.getElementById('formLogin');
const usuarioInput = document.getElementById('usuario');
const claveInput = document.getElementById('clave');
//const rolInput = document.getElementById('rol');
const mensajeLogin = document.getElementById('mensajeLogin');
const loaderSistema = document.getElementById('loaderSistema');
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
  
  loaderSistema.classList.remove('d-none');
  const usuario = usuarioInput.value.trim();
  const clave = claveInput.value.trim();

  if (!usuario || !clave) {
    mostrarMensaje('Ingrese usuario y contraseña.', 'danger');
	loaderSistema.classList.add('d-none');
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
	  loaderSistema.classList.add('d-none');
      return;
    }

    //if (rolInput.value && rolInput.value !== data.usuario.rol) {
      //mostrarMensaje('El rol seleccionado no corresponde al usuario.', 'danger');
      //return;
    //}

    localStorage.setItem('token', data.token);
    localStorage.setItem('usuarioSesion', JSON.stringify(data.usuario));
	loaderSistema.classList.add('d-none');

    //mostrarMensaje('Ingreso exitoso. Inicializando plataforma...', 'success');
	btnVerClave.disabled = true;
	document.body.style.opacity = '0';

    setTimeout(() => {
	  window.location.href = 'dashboard.html';
	}, 300);

  } catch (error) {
    console.error(error);
	loaderSistema.classList.add('d-none');
    mostrarMensaje('No fue posible conectar con el backend.', 'danger');
  }
});

function mostrarMensaje(texto, tipo) {
  mensajeLogin.className = `alert alert-${tipo}`;
  mensajeLogin.textContent = texto;
  mensajeLogin.classList.remove('d-none');
}