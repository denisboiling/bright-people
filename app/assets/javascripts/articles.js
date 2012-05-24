$(".new-comment").click(function(){
    parent_comment = $(this).attr('id');
    $(this).parent().append("<input type=\"text\" id=\"comment-text\"></input>");
    $(this).parent().append("<button type=\"button\" class=\"save-comment\">Save reply!</button>")
    regex = /articles\/(\d+)/
    article_id = regex.exec(window.location.href)[1]
    $(this).remove();
    $(".save-comment").click(function(){
        $.ajax({
            type: "POST",
            url: "/articles/" + article_id + "/article_comments",
            data: {content: $("#comment-text").val(), parent_comment_id: parent_comment},
            success: function(data){location.reload();}
        });
    });
});
