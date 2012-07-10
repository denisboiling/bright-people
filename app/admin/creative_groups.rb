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
    column :description
    default_actions
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :name
      f.input :profession
      f.input :description
      f.input :avatar, as: :file, hint: f.template.image_tag(f.object.avatar.url)
    end
    f.buttons
  end

  show do
    attributes_table :name, :profession, :description

    panel 'Фотография' do
      image_tag(creative_group.avatar.url(:original))
    end

  end
end
