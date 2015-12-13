$(document).ready(function(){
    $('a.edit_comment_link').click(function(){
        var comment_id = $(this).data('commentId');
        var form = $('form#edit_comment_'+ comment_id);
        var title = $('#comment_'+comment_id);


        if ($(this).hasClass('cancel')){
            $(this).html('Изменить');
            $(this).removeClass('cancel');
        } else {
            $(this).html('Отмена');
            $(this).addClass('cancel');
        };

        form.toggle();
        title.toggle();
    });
});
