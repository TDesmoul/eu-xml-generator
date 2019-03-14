function setMinHeight() {
  const cont = document.querySelector(".min-full-height");
  if (cont && cont.offsetHeight === window.innerHeight) {
    cont.style.minHeight = "auto";
    height = window.innerHeight - cont.offsetTop;
    cont.style.minHeight = height + 'px';
  }
}
setMinHeight();
