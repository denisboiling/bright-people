# -*- coding: utf-8 -*-
ActiveAdmin.register SpecialProject do

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

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :title
      f.input :content, input_html: {size: 10}
      f.input :picture, as: :file, hint: f.template.image_tag(f.object.picture.url(:medium))
      f.input :special_project_tag_list
    end
    f.buttons
  end

  show do
    attributes_table :title, :author, :content, :created_at, :updated_at, :picture, :special_project_tag_list

    panel 'Фотография' do
      image_tag(special_project.picture.url)
    end
  end
end
