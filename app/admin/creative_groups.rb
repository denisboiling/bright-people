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
    column :priority
    default_actions
  end

  form partial: 'form'

  show do
    attributes_table :name, :profession, :description, :priority

    panel 'Фотография' do
      image_tag(creative_group.avatar.url(:original))
    end

  end
end
