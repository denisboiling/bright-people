# -*- coding: utf-8 -*-
ActiveAdmin.register Contest do
  menu label: "Конкурсы"

  filter :name
  filter :category

  index do
    id_column
    column :name
    column :category
    default_actions
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :name
      f.input :category, include_blank: false
      f.input :description, input_html: {size: 10}
      f.input :picture, as: :file, hint: f.template.image_tag(f.object.picture.url(:medium))
    end
    f.buttons
  end

  show do
    attributes_table :id, :name, :description, :started_at, :ended_at, :category

    panel 'Фотография' do
      image_tag(contest.picture.url)
    end
  end
end
