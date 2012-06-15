# encoding: utf-8

module FavouritesHelper
  def favourite_block(object)
    return '' unless current_user
    
    args = { relation_id: object.id,
             relation_type: object.class.name,
             user_id: current_user.id }
    if Favourite.where(args).any?
      content_tag :span, link_to("Избранное", '#'), class: :favourite_block_is
    else
      content_tag :span, link_to("В избранное", '#'), class: :favourite_block_add
    end
  end
end
