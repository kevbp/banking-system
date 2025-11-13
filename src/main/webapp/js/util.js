document.addEventListener('DOMContentLoaded', () => {
    const modalEditarMoneda = document.getElementById('modalEditarMoneda');
    modalEditarMoneda.addEventListener('show.bs.modal', function (event) {
        // Obtén el botón que activó el modal
        const button = event.relatedTarget;
        
        // Recupera los datos de los atributos `data-*` del botón
        const codMoneda = button.getAttribute('data-codMoneda');
        const descMoneda = button.getAttribute('data-descMoneda');
        const simbolo = button.getAttribute('data-simbolo');
        
        // Asigna los valores a los campos del modal
        modalEditarMoneda.querySelector('#codMoneda').value = codMoneda;
        modalEditarMoneda.querySelector('#descMoneda').value = descMoneda;
        modalEditarMoneda.querySelector('#simbolo').value = simbolo;
    });
});