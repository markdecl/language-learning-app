

// jQuery
// Target the button click...
// $('.show-answer-button').click(function (e) {
//   // toggle the flip class
//   $('.flashcard').toggleClass('flipped')
// });

// JS
// document.querySelector(".show-answer-button").addEventListener("click", function () {
//   document.querySelector('.flashcard').classList.toggle('flipped');
// });

// Click 'Show answer' button:
document.addEventListener('turbolinks:load', () => {
  const flipFlashcardButton = document.getElementById("show-answer-button");
  flipFlashcardButton.addEventListener('click', (event) => {
    // hello('JavaScript')
    document.querySelector('.flashcard').classList.toggle('flipped');
  });
});

// Press spacebar:
document.body.onkeyup = function (e) {
  if (e.keyCode == 32) {
    document.querySelector('.flashcard').classList.toggle('flipped');
  }
}
