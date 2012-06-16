# -*- coding: utf-8 -*-
ActiveAdmin.register SpecialProject do
  menu label: 'Специальные проэкты'

  filter :title
  filter :author

  index do
    id_column
    column "Фотография" do |special_project|
      link_to image_tag(special_project.picture.url(:thumb), alt: special_project.title), admin_special_project_path(special_project)
    end
    column :title
    column :author
    default_actions
  end

  form partial: 'form'

  show do
    attributes_table :title, :author, :created_at, :updated_at, :picture, :special_project_tag_list

    panel 'Контент' do
      simple_format special_project.content
    end

    panel 'Фотография' do
      image_tag(special_project.picture.url)
    end
  end
end
