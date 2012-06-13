# -*- coding: utf-8 -*-
ActiveAdmin.register Teacher do
  menu label: 'Преподаватели'

  filter :name
  filter :activity

  index do
    id_column
    column "Фотография" do |teacher|
        link_to image_tag(teacher.photo.url(:thumb), alt: teacher.name),
                admin_teacher_path(teacher)
    end
    column :name
    column :created_at
    column :updated_at
    column :activity
    default_actions
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :name
      f.input :description, input_html: {size: 10}
      f.input :photo, as: :file,
                      hint: f.template.image_tag(f.object.photo.url(:medium))
      f.input :activity, as: :select, collection: Activity.all
    end
    f.buttons
  end

  show do
    attributes_table :name, :description, :created_at, :updated_at, :activity

    panel 'Фотография' do
      image_tag(teacher.photo.url)
    end
  end
end
