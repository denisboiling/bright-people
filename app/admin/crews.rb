# -*- coding: utf-8 -*-
ActiveAdmin.register Crew do
  menu label: 'Команда', :parent => "Фестиваль"

  filter :title

  index do
    id_column
    column "Фотография" do |cr|
        link_to image_tag(cr.photo.url(:thumb), alt: cr.name), admin_crew_path(cr)
    end
    column :name
    column :description
    default_actions
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :name
      f.input :description
      f.input :photo, as: :file, hint: f.template.image_tag(f.object.photo.url)
    end
    f.actions
  end

  show do
    attributes_table :name, :description

    panel 'Фотография' do
      image_tag(crew.photo.url(:original))
    end

  end
end
