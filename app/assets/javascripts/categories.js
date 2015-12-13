$(document).ready(function(){
    $('a.edit_category_link').click(function(){
        var category_id = $(this).data('categoryId');
        var form = $('form#edit_category_'+ category_id);
        var title = $('#category_'+category_id);


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
