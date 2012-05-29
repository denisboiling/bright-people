# -*- coding: utf-8 -*-
ActiveAdmin.register Contest do
  menu label: "Конкурсы"
  
  index do
    id_column
    column :name
    column :category
    column :created_at
    column :updated_at
    default_actions
  end
  
  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :name
      f.input :category
      f.input :description, input_html: {size: 10}
      f.input :picture, as: :file, hint: f.template.image_tag(f.object.picture.url(:medium))
    end
    f.buttons
  end
end
