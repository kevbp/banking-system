document.addEventListener("DOMContentLoaded", () => {
  const reg = document.getElementById("region");
  const prov = document.getElementById("provincia");
  const dist = document.getElementById("distrito");

  reg.addEventListener("change", () => {
    const valor = reg.value;
    prov.innerHTML = '<option value="">Seleccione...</option>';
    dist.innerHTML = '<option value="">Seleccione...</option>';

    if (valor !== "") {
      fetch(`${contextPath}/ControlUtilitarios?accion=listarProvincias&valor=${valor}`)
        .then(res => res.json())
        .then(data => {
          data.forEach(p => {
            prov.innerHTML += `<option value="${p}">${p}</option>`;
          });
        });
    }
  });

  prov.addEventListener("change", () => {
    const valor = prov.value;
    dist.innerHTML = '<option value="">Seleccione...</option>';

    if (valor !== "") {
      fetch(`${contextPath}/ControlUtilitarios?accion=listarDistritos&valor=${valor}`)
        .then(res => res.json())
        .then(data => {
          data.forEach(d => {
            dist.innerHTML += `<option value="${d}">${d}</option>`;
          });
        });
    }
  });
});
