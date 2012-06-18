# -*- coding: utf-8 -*-
ActiveAdmin.register Sponsor do
  menu label: 'Попечительский совет'

  filter :first_name
  filter :last_name

  index do
    id_column
    column :photo do |sponsor|
      link_to image_tag(sponsor.photo.url), admin_sponsor_path(sponsor)
    end
    column :first_name
    column :last_name
    default_actions
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :first_name
      f.input :last_name
      f.input :description
      f.input :photo, as: :file, hint: f.template.image_tag(f.object.photo.url)
    end
    f.buttons
  end

  show do
    attributes_table :id, :first_name, :last_name, :created_at, :updated_at

    panel 'Описание' do
      simple_format resource.description
    end

    panel 'Фотография' do
      link_to image_tag(resource.photo.url), resource.photo.url(:original, timestamp: false)
    end
  end

end
