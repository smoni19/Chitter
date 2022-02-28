function RedBorder(obj) {
  let parent_element = obj.parentElement.parentElement.parentElement;
  parent_element.classList.add("peep_delete");
  parent_element.classList.remove("peep_edit");
  parent_element.style.opacity="1";
}

function OrangeBorder(obj) {
  let parent_element = obj.parentElement.parentElement.parentElement;
  parent_element.classList.add("peep_edit");
  parent_element.classList.remove("peep_delete");
  parent_element.style.opacity="1";
}

function NormalBorder(obj) {
  let parent_element = obj.parentElement.parentElement.parentElement;
  parent_element.classList.remove("peep_delete");
  parent_element.classList.remove("peep_edit");
  parent_element.style.opacity="1";
}