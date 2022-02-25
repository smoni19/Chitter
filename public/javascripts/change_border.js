function RedBorder(obj) {
  obj.parentElement.parentElement.classList.add("peep_delete");
  obj.parentElement.parentElement.style.opacity="0.5";
}

function NormalBorder(obj) {
  obj.parentElement.parentElement.classList.remove("peep_delete");
  obj.parentElement.parentElement.style.opacity="1";
}