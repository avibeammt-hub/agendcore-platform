function mostrarToast(mensaje, tipo = 'success') {

  const toast = document.createElement('div');

  toast.className = `
    toast-custom
    toast-${tipo}
  `;

  toast.innerHTML = `
    <div class="toast-content">
      <i class="bi bi-check-circle-fill"></i>
      <span>${mensaje}</span>
    </div>
  `;

  document.body.appendChild(toast);

  setTimeout(() => {
    toast.classList.add('show');
  }, 100);

  setTimeout(() => {
    toast.classList.remove('show');

    setTimeout(() => {
      toast.remove();
    }, 400);

  }, 3000);
}