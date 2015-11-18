$(document).ready(function() {
  var lessonWords = $("#lesson_words").children('div.row');
  var editLessonForm = $("#edit_lesson");
  var index = 0;

  var unhide = function() {
    if (index > 0) {
      lessonWords.eq(index - 1).addClass('hidden');
    }
    lessonWords.eq(index).removeClass('hidden');
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