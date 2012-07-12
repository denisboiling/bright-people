# -*- coding: utf-8 -*-
ActiveAdmin.register CreativeGroup do
  menu label: 'Творческая группа', :parent => "Фестиваль"

  filter :title

  index do
    id_column
    column "Фотография" do |cr|
        link_to image_tag(cr.avatar.url(:thumb), alt: cr.name), admin_creative_group_path(cr)
    end
    column :name
    column :profession
    default_actions
  end

  form partial: 'form'

  show do
    attributes_table :name, :profession, :description

    panel 'Фотография' do
      image_tag(creative_group.avatar.url(:original))
    end

  end
end
