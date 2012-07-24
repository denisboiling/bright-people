# -*- coding: utf-8 -*-
module FavouritesHelper
  def favourite_block(object)
    return '' unless current_user

    args = { relation_id: object.id,
             relation_type: object.class.name,
             user_id: current_user.id }
    if favourite = Favourite.where(args).first
      content_tag :span, link_to("Избранное", '#'),
                  class: :favourite_block_is,
                  'data-id' => favourite.id,
                  'data-relation-id' => object.id,
                  'data-relation-type' => object.class.name
    else
      content_tag :span, link_to("В избранное", '#'),
                  class: :favourite_block_add,
                  'data-relation-id' => object.id,
                  'data-relation-type' => object.class.name
    end
  end
end
