#= require active_admin/base

# $ ->
#   delete_photo_request =(id) ->


#   $("input.destroy_photo").click ->
#     photo = $(this).attr('data-id')
#     $.ajax '/common_actions/remove_activity_photo',
#       type: 'DELETE',
#       dataType: 'json',
#       data: {id: id}
#       success: (data, textStatus, jqXHR) ->
#         $(this).find
#       false
