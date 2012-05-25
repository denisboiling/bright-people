$ ->
  $('a#create_question').live 'click', (event) ->
    $('.question_div').html($('.question_form').html())
    $(this).remove();
    false
