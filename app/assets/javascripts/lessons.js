$(document).ready(function() {
  var lessonWords = $("#lesson_words").children('div.row');
  var editLessonForm = $("#edit_lesson");
  var lessonCounter = $("#lesson-counter");
  var index = 0;

  var unhide = function() {
    if (index > 0) {
      lessonWords.eq(index - 1).addClass('hidden');
    }
    lessonWords.eq(index).removeClass('hidden');
    lessonCounter.html(index + "/20");
    index += 1;
  };

  unhide();

  editLessonForm.submit(function(event) {
    if (lessonWords.eq(index - 1).find('input:radio').filter(":checked").val()) {
      if (index < 20) {
        unhide();
      } else {
        return true;
      }
    }
    return false;
  });
});