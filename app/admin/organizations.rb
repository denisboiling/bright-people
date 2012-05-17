# -*- coding: utf-8 -*-
ActiveAdmin.register Organization do
  menu :label => 'Организации'

  filter :title

  index do
    id_column
    column :title
    column :address
    column :created_at
    column :updated_at
    default_actions
  end

  form do |f|
    f.inputs 'Основное' do
      f.input :title
      f.input :address
    end
    f.inputs 'Карта' do
      f.input :coords, as: :hidden, input_html: { class: 'hidden_coords'}
      f.input :coords, input_html: { class: 'edit_map' }, label: false
    end
    f.buttons
  end

  show do
    attributes_table :title, :address, :created_at, :updated_at

    panel 'Карта' do
      form do |f|
        input class: 'hidden_coords', value: organization.coords, type: 'hidden'
      end
      div id: 'edit_map' do
      end
    end
  end

end
