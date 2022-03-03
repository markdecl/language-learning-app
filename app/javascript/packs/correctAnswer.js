// Press enter key:
document.body.onkeyup = function (e) {
  if (e.keyCode == 32) {
    document.querySelector('.flashcard').classList.toggle('flipped');
  }
}
