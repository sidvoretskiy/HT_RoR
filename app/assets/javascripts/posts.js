$(document).ready(function(){
    $('form.new_post').submit(function(){
        console.log('Отправка файла');
        var post_title = $(this).find('#post_title');
        console.log(post_title);
        var title = post_title.val();
        if (title == '' || title == undefined) {
            post_title.addClass('field_with_errors');
            alert('Введите название поста');

            return false;

        }

    });
    $('a.edit_post').click(function(){
        var form = $('form.edit_post');
        var title = $('div.post');


        if ($(this).hasClass('cancel')){
            $(this).html('Изменить');
            $(this).removeClass('cancel');
        } else {
            $(this).html('Отмена');
            $(this).addClass('cancel');
        }

        form.toggle();
        title.toggle();
    });

});
