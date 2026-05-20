function mostrarLoader(texto = 'Cargando información...') {

  const loader = document.getElementById('globalLoader');

  if (!loader) return;

  loader.querySelector('.loader-text').textContent = texto;

  loader.classList.remove('d-none');
}

function ocultarLoader() {

  const loader = document.getElementById('globalLoader');

  if (!loader) return;

  loader.classList.add('d-none');
}