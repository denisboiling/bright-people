# -*- coding: utf-8 -*-
ActiveAdmin.register User do
  menu label: 'Экспертный совет'

  filter :name

  index do
    id_column
    column "Фотография" do |expert|
        link_to image_tag(expert.photo.url(:thumb), alt: expert.name),
                admin_expert_path(expert)
    end
    column :name
    column :created_at
    column :updated_at
    default_actions
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :name
      f.input :description, input_html: {size: 10}
      f.input :about
      f.input :photo, as: :file,
                      hint: f.template.image_tag(f.object.photo.url(:medium))
    end
    f.buttons
  end

  show do
    attributes_table :name, :description, :about, :created_at, :updated_at

    panel 'Фотография' do
      image_tag(expert.photo.url)
    end
  end
end
